# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

# テーブル設計

## users テーブル

| Column         | Type   | Options     |
| -------------- | ------ | ----------- |
| nickname       | string | null: false |
| email          | string | null: false |
| password       | string | null: false |
| first_name     | string | null: false |
| family_name    | string | null: false |
| ja_first_name  | string | null: false |
| ja_family_name | string | null: false |
| birth          | date   | null: false |

### Association

- has_many :items
- has_many :purchase_items
- has_many :comments

## items テーブル

| Column           | Type      | Options                        |
| ---------------- | --------- | ------------------------------ |
| name             | string    | null: false                    |
| description      | string    | null: false                    |
| price            | integer   | null: false                    |
| category_id      | integer   | null: false                    |
| condition_id     | integer   | null: false                    |
| fee_id           | integer   | null: false                    |
| region_id        | integer   | null: false                    |
| shipping_days_id | integer   | null: false                    |
| user             | reference | null: false, foreign_key: true |


### Association

- belongs_to :user
- has_many :comments
- has_one :purchase_item

## comments テーブル
| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| message       | text       | null: false                    |
| user          | references | null: false, foreign_key: true |
| item          | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :item



## purchase_items テーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| user          | references | null: false, foreign_key: true |
| item          | references | null: false, foreign_key: true |


### Association

- belongs_to :user
- belongs_to :item
- has_one :address

## addresses テーブル

| Column        | Type       | Options                        |
| -------       | ---------- | ------------------------------ |
| postal_code   | string     | null: false                    |
| prefecture_id | string     | null: false                    |
| city          | string     | null: false                    |
| address_line  | string     | null: false                    |
| phone_number  | string     | null: false                    |
| purchase_item | references | null: false, foreign_key: true |

### Association

- belongs_to :purchase_item