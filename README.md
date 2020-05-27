# Laravel-tweet-ddd-infrastructure

## Overview

- 以下アプリケーションのインフラ構成をコードで管理するリポジトリ
  - https://github.com/naoyaUda/laravel-tweet-ddd

## Environments

- terraform 0.12.14

## Architecture overview

<p align="center">
    <img width="55%" src="https://user-images.githubusercontent.com/43739514/82997718-b3ea0c00-a041-11ea-8f46-42936edf80be.png">
</p>

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
