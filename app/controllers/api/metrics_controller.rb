class Api::MetricsController < ApplicationController
  @@client = Aws::CloudWatch::Client.new

  def disk_read_bytes
    metrics('DiskReadBytes')
  end

  def disk_write_bytes
    metrics('DiskWriteBytes')
  end

  def disk_read_opts
    metrics('DiskReadOps')
  end

  def disk_write_opts
    metrics('DiskWriteOps')
  end

  def cpu_utilization
    metrics('CPUUtilization')
  end

  def cpu_credit_balance
    metrics('CPUCreditBalance')
  end

  def cpu_credit_usage
    metrics('CPUCreditUsage')
  end

  def get_instance_operation_names
    ec2 = Aws::EC2::Client.new
    get_response(ec2.operation_names)
  end

  private

  def metrics(metric)
    payload = create_payload('AWS/EC2', metric)
    get_response(@@client.get_metric_statistics(payload))
  end

  def create_payload(namespace, name)
    payload = {namespace: namespace,
               metric_name: name,
               dimensions: [
                   {
                       name: 'InstanceId',
                       value: params[:instance_id],
                   },
               ],
               start_time: params[:start].to_time.beginning_of_month,
               end_time: params[:end].to_time.end_of_month,
               period: 3600,
               statistics: ['Average', 'Minimum', 'Maximum']
    }
  end
end
