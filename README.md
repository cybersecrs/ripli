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
  
If you want to build a gem, run:

```bash
gem build clit.gemspec
```

---
## Usage

Executing `bin/ripli.rb` start scrap and download *proxychains lists.* There's just one class atm,
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

 - E-mail address:     linuxander88@gmail.com  
 - GitHub Page:        [Ripli web page](https://www.cybersecrs.github.io/ripli)  
 - PGP key:             
```
-----BEGIN PGP PUBLIC KEY BLOCK-----

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
=FfF9
-----END PGP PUBLIC KEY BLOCK-----
``` 

---
## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
