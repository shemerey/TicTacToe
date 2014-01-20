<!---
vim:fen:fdm=marker:fmr={{{,}}}:fdl=0:fdc=1:ts=2:sw=2:sts=2:nu
-->
## Tic Tac Toe

This repository created for one particular purpose, practise in refactoring and vim
skills.

There are [Original Tic Tac Toe gem](https://github.com/jisaacks/ruby-tic-tac-toe) and
[article](http://www.jisaacks.com/ruby-tutorial-make-a-tic-tac-toe-game) about this game

By the way, all commits are meaningful, which means there are no faild commits, and
original behaviour still here. Each commit, is a litle step forward to new code
structure with old behavior

<!--- {{{ -->
### 1 Step (Setup)

Setup environment:

* Add some gems for development
  * `simplecov,` `cadre,` `pry,` `pry-debugger`
  * setup `spec/spec_helper.rb`
  * setup cadre support (display code coveradge in `vim`)
    * keep `.cadre/coverage.vim` under git controll, it alows to build coveradge report in
      future, for each commit.
  * update README file, add vim `modeline` to manage steps description
* Write first isolated test
  * capture STDOUT and match result

Current Gemfile looks like:

```ruby
gem 'simplecov'
gem 'pry'
gem 'pry-debugger'
gem 'cadre'
```

Current work dir looks like:

```
.
├── Gemfile
├── README.md
├── Rakefile
├── lib
│   └── tic_tac_toe.rb
├── spec
│   ├── spec_helper.rb
│   └── tic_tac_toe_spec.rb
```

#### Result
Now we have everething to start build our test suit, one test pass and we have proper
tools to measure code coverage
<!--- }}} -->


