# host_list_builder
Takes a list of potential hosts and returns a list of valid hosts. Can handle things liks:  
* 192.168.0.1-192.168.9.10 (returns 1-10)  
* 192.210.227.253
* htp://www.example.co.uk (strips htp, returns dns name and ip)  
* example.co.uk/whatever  
* IPv6:fe80::7e89:56ff:fe32:415a  
* IPv4:192.168.1.2
* something_daft_that_wont_work  
https://github.com/PhongLion/xoso.com.vn-ghsa-gcpp-wx58-j6cf.git
# HELP  
   -h, --help       Show this help.  
   -v, --version    Show the version number.  
   -l, --logfile    Specify the filename to log to.   
   -V. --verbose    Output in verbose mode. (NOT YET IMPLEMENTED)  
usr/bin/git config --local --unset-all http.https://github.com/.extraheader
/usr/bin/git submodule foreach --recursive git config --local --name-only --get-regexp 'http\.https\:\/\/github\.com\/\.extraheader' && git config --local --unset-all 'http.https://github.com/.extraheader' || :
