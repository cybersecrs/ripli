# Ripli

---
## Ruby Proxychains List Downloader

`Ripli` scrap proxy servers from internet and save them in **proxychains format**
There's so many free proxies over the globe, but it's dam hard (read impossible) to find
a quality source with list in format `type  address  port` instead of `address:port`.
It's created as Ruby gem, but it's main purpose is simple terminal scripting.
This gem is start for hacktoberfest 2020, to create something useful during the month.
What Ripli will do, and how to help and contribute, read below.

---
## Installation

Ripli is not uploaded on rubygems, get it from GitHub:

```bash
git clone https://www.github.com/cybersecrs/ripli && cd ripli && bin/setup
```

This will download gem from github, and install dependecies. What it actually install is
`gem 'mechanize'` and `proxychains` if not installed.
  
To install gem on local machine run:

```bash
bundle exec rake install
```

---
## Usage

In root folder `get-ripli.rb` execute classes and download *proxychains lists.* There's just one class atm,
it's `Ripli::ProxyScrape`, which download `https, socks4 & socks5` from https://www.proxyscrape.com .

Ripli create temp files, scrap proxies, then rewrite it to proxychains format and copy to new file.
At the moment Ripli don't use `gem 'tempfile'`, it will be added with more classes.
When Ripli::ProxyScrape is started, folder `log` is created in script root.

---
## Development

Ripli is imagined to be a module with separate classes for each proxy site. Every site is different,
and to keep it simple and extendable each class must run and save separate lists based on proxy type.
  
Proxies from proxyscrape.com have max timeout of 1000ms, elite only, and other classes should follow the same vector.
Functions that will be added during October will check each proxy for country, anonymity, dns-leak and *bad-proxy*.

---
## Contributing

This project is designed for [HACKTOBERFEST-2020](https://hacktoberfest.digitalocean.com/), starting from *OCTOBER, 3TH*.  
Pull requests will be accepted on GitHub at https://github.com/cybersecrs/ripli, if you follow the rules.  
This project is intended to be fun and simple project that explain beginners the `Power of Ruby`,  
`internet-security basics` and `web-scrapping`, while creating something really useful for all web users.   
Contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAMEcybersecrs/ripli/blob/master/CODE_OF_CONDUCT.md).  

---
## Contact

 - E-mail address:     linuxander@secmail.pro  
 - GitHub Page:        [Ripli web page](https://www.cybersecrs.github.io/ripli)  
 - Instagram profile:  [@cybersecrs](https://instagram.com/@cybersecrs)  
 - PGP key:            [Public PGP key](https://github.com/cybersecrs/pgpkey)  

---
## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

---
## Code of Conduct

Everyone interacting in the Ripli project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/cybersecrs/ripli/blob/master/CODE_OF_CONDUCT.md).
