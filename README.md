bash-proxy.sh
========

Automatic set http_proxy/https_proxy before a command executes and unset http_proxy/https_proxy after a command executed.
You can specify the matched site in `site_list` and the matched prefix command name in `cmd_list`.
Automatic load `site_list` and `cmd_list` when you have modified it.
It will do nothing if you already set http_proxy/https_proxy.


## Install

* Install [bash-preexec](https://github.com/rcaloras/bash-preexec)
* Install bash-proxy
```bash
# git clone project
git clone https://github.com/faicker/bash-proxy ~/.proxy.d
# new site and cmd config file
cd ~/.proxy.d && cp site_list{.example,} && cp cmd_list{.example,}
# Define your own proxy and source file in bash profile
echo "
myhttp_proxy=http://192.168.1.1:2181
myhttps_proxy=http://192.168.1.1:2181
[[ -f ~/.proxy.d/bash-proxy.sh ]] && source ~/.proxy.d/bash-proxy.sh
" >> ~/.bashrc
```
* Start a new shell and enjoy

## License

This project is under the MIT license. See the [LICENSE](LICENSE) file for the full license text.
