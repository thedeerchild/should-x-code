# Should \_\_\_\_ Code?

Should-x-code attempts to address the classic philosophical question "should designers code?" It does so by bringing more granularity to the problem and asking about individual cases on from the [Authentic Jobs](https://authenticjobs.com/) API, to save us from having to reason in the abstract.

Tweets at [@should_x_code](https://twitter.com/should_x_code).

## Development

Assumes that you have Ruby installed on your system. First, install dependencies with Bundler.

```bash
gem install bundler
bundler install
```

Next, copy over the `sample.env` file and fill in your API keys and OAuth tokens for Twitter, your API keys for Authentic Jobs and your Redis connection details. For generating the OAuth tokens, I highly recommend the [twurl](https://github.com/twitter/twurl) tool, which will save them in a file at `~/.twurlrc`.

```bash
cp sample.env .env
nano .env
```

Finally, run the bot with

```bash
bundle exec ruby tweet.rb
```

Job listings will not be repeated within 30 days, and tweets at people who follow the bot will never be repeated. Only tweets with a given probability when the script is run, for easier integration with the [Heroku Scheduler](https://elements.heroku.com/addons/scheduler).