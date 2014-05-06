chef-fulcrum Cookbook
=====================

Fulcrum (http://wholemeal.co.nz/projects/fulcrum.html) のcookbook

インストール、初期設定、railsで実行まで

検証用として作成したので実行時環境(RAILS_ENV)はdevelopmentで、DBはSQLiteを使用します。

Requirements
------------

- CentOS 6.4 x86_64
- Ruby(>1.9.3p286)
- RubyGems (http://rubygems.org/)
    - bundler 
    - execjs
- Cookbooks
    - yum (https://github.com/opscode-cookbooks/yum)

Usage
-----
#### chef-fulcrum::default
Just include `chef-fulcrum` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[chef-fulcrum]"
  ]
}
```

