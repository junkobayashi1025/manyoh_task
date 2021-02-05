# README

## table
Userテーブル

|  Column   |  Type    |
| --------  | -------- |
|  name     |  string  |
|  email    |  string  |
| password_digest | string |

Taskテーブル

|  Column   |  Type   |
| --------  | --------|
| title     | string  |              
| content   | text    |
| deadline  | datetime|
| status    | string  |
| priority  | string  |
| user_id   | index   |


Labelテーブル

|  Column   |  Type    |
| --------  | -------- |
| task_id   | index  |
| user_id   | index  |

## Herokuへのデプロイ手順

1. Herokuにログインする
 $ heroku login
※ここで Waiting for login... で進まない場合は、
 $ heroku login --interactive

2. コミットする
 $ git add -A
 $ git commit -m "init"

3. Herokuに新しいアプリケーションを作成する
 $ heroku create

4. Heroku stackを変更する
 $ heroku stack:set heroku-18

5. Heroku stackが変更されたか確認
 $ heroku stack
※* heroku-18となっていればOK

6. Heroku buildpackを追加する
 $ heroku buildpacks:set heroku/ruby
 $ heroku buildpacks:add --index 1 heroku/nodejs

7. Herokuにデプロイをする
 $ git push heroku master

8. データベースの移行
 $ heroku run rails db:migrate

9. アプリケーションにアクセスする
 Herokuアプリのアドレスはhttps://アプリ名.herokuapp.com/
