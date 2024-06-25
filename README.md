# CBOT-soy-price-api
Simple API wich returns soy price and its variations each 5 minutes.

**Using locally:**<br>
1- Clone this repository.<br>
2- Install gems in Gemfile using "bundle".<br>
3- Run the code with: "ruby soy-crawler.rb" in terminal.

**EndPoints:**<br>
- / (root): returns Chicago prices and its variations.
- /cbot-price: returns Chicago (CBOT) price, its variations and unit.
- /paranagua-price: returns port of Paranaguá/PR price and its variations.
- /santos-price: returns port of Santos/SP price and its variations.
