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
