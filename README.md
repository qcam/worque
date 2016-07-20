# Worque

Worque is a CLI which is helpful to manage your daily notes.

* Ever stunned when your boss suddenly asked what you've done yesterday?
* Wanna check/note your daily tasks without exiting your favourite editor `VIM`?
* Something to report on daily stand-ups?

Then worque is definitely a right tool for you!

## Installation

**DO NOT add this to your Gemfile**

Install it by

    $ gem install worque

## Quick start guide

### CLI

Add this to your `.bash_profile`

```sh
export WORQUE_PATH='/path/to/your/lovely/notes'
```

I often map it to my Dropbox like this

```sh
export WORQUE_PATH='~/Dropbox/Notes/Todos'
```

Then executing the command below will create a today's note for you

```sh
worque --today
# ~/notes/checklist-2016-07-19.md
```

Or look back what's done yesterday.

```sh
workque --yesterday
# ~/notes/checklist-2016-07-18.md
# This will jump back to Friday's note if it's Monday today!
```

You can also explicitly specify the file path

```sh
worque --today --path ~/path/to/your/notes
```

It's chain-able with other commands

```sh
vim worque
vim $(worque --yesterday)
cat $(worque --yesterday) | grep pending
```

Personally I alias it like `today` like this, so vim will automatically open the
file when I type `today`

```sh
alias today="vim $(worque --today) +':cd $WORQUE_PATH'"
alias ytd="vim $(worque --today) +':cd $WORQUE_PATH'"
```

### VIM Integration

Add this to your VIM plugin manager

```viml
Plug 'huynhquancam/vim-worque'
```

Then `:TD`, `:YTD` for today and yesterday's notes respectively.

Read more about [vim-worque](https://github.com/huynhquancam/vim-worque).

View more in my [dotfiles](https://github.com/huynhquancam/dotfiles)

## Development

```sh
bundle install
bundle exec rake test
```

## To be implemented

Something in my plan:

* Test suites: Embarrassingly there's no test currently, but this will be my
  first priority.
* `worque list`: List all notes you have.
* `worque push`: Push your daily notes to your specified Slack channel.
* `worque changelog`: Sync your Git commits to daily notes.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/huynhquancam/worque.

## License

The gem is available as open source under the terms of the
[MIT License](http://opensource.org/licenses/MIT).

