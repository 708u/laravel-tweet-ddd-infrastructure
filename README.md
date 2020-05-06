# Laravel-tweet-ddd-infrastructure

## Overview

- 以下アプリケーションのインフラ構成をコードで管理するリポジトリ
    - https://github.com/naoyaUda/laravel-tweet-ddd-infrastructure

## Installation

- 公式のdockerイメージを使ってterraformを実行しているため、dockerとdocker-comopseをインストールしてください

```bash
$ cp terraform.tfvars.sample terraform.tfvars
$ make tf init
```

## How to use

- 各種terraformコマンド実行

```bash
$ make plan
$ make apply
$ make destroy
```

- format

```bash
$ make format
```
