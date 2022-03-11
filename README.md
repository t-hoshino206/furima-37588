## usersテーブル

| Column          | Type       | Options                   |
| --------------- | ---------- | ------------------------- |
| nickname        | string     | null: false               |
| email           | string     | null: false, unique: true |
| password        | string     | null: false               |
| last_name       | string     | null: false               |
| first_name      | string     | null: false               |
| last_name_kana  | string     | null: false               |
| first_name_kana | string     | null: false               |
| birth_year      | integer    | null: false               |
| birth_month     | integer    | null: false               |
| birth_day       | integer    | null: false               |


### Association

- has_many :items
- has_one :sending_info


## itemsテーブル

| Column            | Type       | Options                        |
| ----------------- | ---------- | ------------------------------ |
| image             | text       | null: false                    |
| name              | string     | null: false                    |
| description       | text       | null: false                    |
| category          | string     | null: false                    |
| condition         | integer    | null: false                    |
| shipping_fee      | integer    | null: false                    |
| shipping_area     | integer    | null: false                    |
| shipping_schedule | integer    | null: false                    |
| price             | integer    | null: false                    |
| user              | references | null: false, foreign_key: true |


### Association

- belongs_to :user
- has_one :order


## ordersテーブル

| Column       | Type       | Options                        |
| ------------ | ---------- | ------------------------------ |
| soldout      | integer    | null: false                    |
| item         | references | null: false, foreign_key: true |


### Association

- belongs_to :item
- has_one :sending_info


## sending_infosテーブル

| Column       | Type       | Options                        |
| ------------ | ---------- | ------------------------------ |
| postal_code  | string     | null: false                    |
| prefecture   | string     | null: false                    |
| city         | string     | null: false                    |
| address      | string     | null: false                    |
| phone_number | string     | null: false                    |
| user         | references | null: false, foreign_key: true |


### Association

- belongs_to :user
- has_many :orders