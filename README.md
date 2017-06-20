# host_list_builder
Takes a list of potential hosts and returns a list of valid hosts. Can handle things liks:  
* 192.168.0.1-192.168.9.10 (returns 1-10)  
* 192.168.9.1/24  
* htp://www.example.co.uk (strips htp, returns dns name and ip)  
* example.co.uk/whatever  
* IPv6  
* IPv4  
* something_daft_that_wont_work  

# HELP  
   -h, --help       Show this help.  
   -v, --version    Show the version number.  
   -l, --logfile    Specify the filename to log to.   
   -V. --verbose    Output in verbose mode. (NOT YET IMPLEMENTED)  
