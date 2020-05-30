# Laravel-tweet-ddd-infrastructure

## Overview

- 以下アプリケーションのインフラ構成をコードで管理するリポジトリ
  - https://github.com/naoyaUda/laravel-tweet-ddd

## Environments

- terraform 0.12.14

## Architecture overview

<p align="center">
    <img src="https://user-images.githubusercontent.com/43739514/82998236-70dc6880-a042-11ea-8bd9-d8dbb23f4af3.png">
</p>

- AWS無料枠に収まる範囲内で構築となるため、マルチAZなど、冗長化構成は取っておりません。

## Installation

- 公式の docker イメージを使って terraform を実行しているため、docker と docker-comopse をインストールしてください

```bash
$ cp terraform.tfvars.sample terraform.tfvars
$ make tf init
```

## How to use

- 各種 terraform コマンド実行

```bash
$ make plan
$ make apply
$ make destroy
```

- format

```bash
$ make format
```
