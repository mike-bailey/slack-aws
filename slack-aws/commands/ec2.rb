module SlackAws
  module Commands
    class EC2 < SlackRubyBot::Commands::Base
      extend SlackAws::Util::AwsClientResponse

      command 'ec2' do |client, data, match|
        arguments = match['expression'].split.reject(&:blank?) if match.names.include?('expression')
        case arguments && arguments.shift
        when 'instances' then
         reap = Aws::EC2::Client.new.describe_instances()
          reap = Aws::EC2::Client.new
          instances = reap.describe_instances()
          reservationdescrip = ""
          instanceprofile = "\n*Summary*:\n"

          instances.reservations.each do |reservation|
            reservation.instances.each do |instance|
              if instance.state.name != "running"
                next
              end
              instanceprofile = 
              "\n#{instanceprofile}\n
              *Instance Identifier:* #{instance.instance_id }\n
              *IP Address:* #{instance.public_ip_address }\n
              *Image Identifier:* #{instance.image_id }\n
              *Instance Type:* #{instance.instance_type }\n"
            end
          end
        else
          client.say(text: 'Syntax: aws ec2 [command], need `aws help`? Message @awsbot help.', channel: data.channel)
        end
      end
    end
  end
end
