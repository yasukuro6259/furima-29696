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

| Column         | Type    | Options     |
| -------------- | ------  | ----------- |
| nickname       | string  | null: false |
| email          | string  | null: false |
| password       | string  | null: false |
| first_name     | string  | null: false |
| family_name    | string  | null: false |
| ja_first_name  | string  | null: false |
| ja_family_name | string  | null: false |
| birth_year     | integer | null: false |
| birth_month    | integer | null: false |
| birth_day      | integer | null: false |

### Association

- has_many :items
- has_many :purchase_items
- has_many :comments

## items テーブル

| Column         | Type      | Options                        |
| -------------- | --------- | ------------------------------ |
| image          | string    | null: false                    |
| name           | string    | null: false                    |
| description    | string    | null: false                    |
| price          | integer   | null: false                    |
| category       | string    | null: false                    |
| condition      | string    | null: false                    |
| fee            | integer   | null: false                    |
| region         | string    | null: false                    |
| shipping_days  | integer   | null: false                    |
| user           | reference | null: false, foreign_key: true |


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
| credit_number | integer    | null: false                    |
| cvc           | integer    | null: false                    |
| exp_month     | integer    | null: false                    |
| exp_year      | integer    | null: false                    |
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
| prefecture    | string     | null: false                    |
| city          | string     | null: false                    |
| address_line  | string     | null: false                    |
| phone_number  | integer    | null: false                    |
| purchase_item | references | null: false, foreign_key: true |

### Association

- belongs_to :purchase_item