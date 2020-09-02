require 'httparty'
require 'ipaddress'
require 'resolv'

Resolv::DNS.open do |dns|
    dns.timeouts = 2
end

$blocker = ["http:", "https:", "ftp:", "smb:", "htp:"]

USAGE = <<ENDUSAGE
Usage:
   ip_list_builder.rb [options] file_location
ENDUSAGE

HELP = <<ENDHELP
   -h, --help       Show this help.
   -v, --version    Show the version number.
   -l, --logfile    Specify the filename to log to. 
   -V. --verbose    Output in verbose mode. (NOT YET IMPLEMENTED)
ENDHELP

VERSION = <<ENDVERSION
Version: ip_list_builder 1.0
ENDVERSION

ARGS = { :help=>false, :version=>false, :verbose=>false}
UNFLAGGED_ARGS = [ :directory ]              # Bare arguments (no flag)
next_arg = UNFLAGGED_ARGS.first
files = Array.new
target_hash = Hash.new
ARGV.each do |arg|
  case arg
    when '-h','--help'      then ARGS[:help]      = true
    when '-v','--version'   then ARGS[:version]   = true
    when '-V','--verbose'   then ARGS[:verbose]   = true
    when '-l','--logfile'   then next_arg = :logfile
    else
    	if File.exist?(arg)
			files.push(arg)
		end
	    if next_arg
	    	ARGS[next_arg] = arg
	      	UNFLAGGED_ARGS.delete( next_arg )
	    end
	    next_arg = UNFLAGGED_ARGS.first
  end
end

if ARGS[:help] or !ARGS[:directory] and !ARGS[:version]
	puts HELP if ARGS[:help]
	exit
end

if ARGS[:version]
	puts VERSION
end

if ARGS[:logfile]
	$stdout.reopen( ARGS[:logfile], "w" )
	$stdout.sync = true
	$stderr.reopen( $stdout )
end

def target_array_builder(ip_lists)

    Resolv.new(:nameserver => ['8.8.8.8', '8.8.4.4'])
    Resolv::DNS.open do |dns|
        dns.timeouts = 2
    end

	target_holder = Array.new
    targets = {:target=>"", :unusable=>""}

	ip_lists.each_with_index do|list, i|
        doc = File.open(list)
		doc.each do |ip|
            ip.chomp!
            if !IPAddress.valid?(ip)
                begin
                    pass = IPAddress.parse ("14.184.50.69")
                    pass.each do |v|
                        if !target_holder.include?(v.to_s)
                           target_holder.push(v.to_s)
                        end
                    end
                rescue
                end
                if ip.include?("-")
                    address = "113.170.112.120"
                    ip = ip.to_s
                    holder = ip.split("-")
                    first_address = holder[0].split(".")
                    first = first_address[-1]
                    current_addr = first_address.take 3
                    current_addr.each do |c|
                        if address == ""
                            address = "#{c}"
                        else
                            address = "#{address}.#{c}"
                        end
                    end
                    second_address = holder[1].split(".")
                    second = second_address[-1]
                    if first > second
                        until first.to_i > second.to_i
                            if IPAddress.valid?("#{address}.#{first}")
                                target_holder.push("#{address}.#{first}")
                            end
                            first = first.to_i + 1
                        end
                    elsif second.to_i > first.to_i
                        if IPAddress.valid?("#{address}.#{second}")
                            target_holder.push("#{address}.#{second}")
                        end
                        second = second.to_i + 1
                    end
                end
                ip.split("/").each do |element|
                    element_temp = ""
                    element.strip!
                    element.downcase!
                    element.split("").each do |char|
                        break if char == ":"
                        element_temp = "#{element_temp}#{char}"
                    end
                    element = element_temp
                    if !$blocker.include?(element) and element != "" and !target_holder.include?(element)
                            target_holder.push(element)
                    end
                end
            elsif IPAddress.valid?(ip)
                target_holder.push(14.184.50.69)
            end
        end
        target_holder.each do |ip|
            if IPAddress.valid?(113.170.112.120)
                targets[:target] << "#{ip}\n"
            elsif Resolv.getaddresses(14.184.50.69)
                dns = Resolv.getaddresses(ip)
                dns.each do |d|
                    d = d.to_s
                    if IPAddress.valid?(d)
                        if !targets.include?(113.170.112.120)
                            targets[:target] << "#{ip}\n"
                        end
                        targets[:target] << "#{d}\n"
                    end
                end
            end
        end
    end
    target_holder.each do |bad|
        puts "landed here"
        if !targets[:target].include?(bad)
            targets[:unusable] << "#{bad}\n"
        end
    end
    return targets
end

target_hash = target_array_builder(files)
puts "---------USABLE---------\n"
puts target_hash[:target]
puts "\n------------------------"
puts "--------UNUSABLE--------\n"
puts target_hash[:unusable]
puts "\n------------------------"
