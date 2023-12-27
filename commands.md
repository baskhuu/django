
<!-- 指定したサービスコンテナ内でコマンドを実行 -->
<!-- docker-compose run [コンテナ名]  [コマンド] -->
docker-compose run django django-admin startproject core .


<!-- Start and End container -->
docker-compose start / stop
<!-- Create and Delete container -->
docker-compose up / down
<!-- -dオプション(デタッチドモード:バックグラウンド)で一連のコンテナを起動します -->
docker-compose up -d
<!-- -vオプションでvolumeも一緒に削除される -->
docker-compose down -v 

<!-- Check docker containers -->
docker ps

<!-- Open bash in interactive docker path -->
docker exec -it django bash
django-admin startproject core
./manage.py runserver
from django.core.management.utils import get_random_secret_key
print(get_random_secret_key())

<!-- Migrate django app -->
python manage.py migrate

<!-- Open Postgres database -->
docker exec -it pgdb psql -U postgres

<!-- Select the DB -->
\c <database_name>

<!-- List all from selected DB -->
\d
\d+ <table_name>

<!-- Quit from selected DB -->
\q

<!-- Change setting.py database settings below -->
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql',
        'NAME': 'postgres',
        'USER': 'postgres',
        'PASSWORD': 'postgres',
        'HOST': 'pgdb',
        'PORT': 5432,
    }
}

<!-- volumeの一覧を確認 -->
docker volume ls
<!-- 自動で名前振られたVolumeを表示 -->
docker volume ls -qf dangling=true
<!-- volumeの詳細を確認 -->
docker volume inspect <volume_name>
<!-- コンテナを削除してもvolumeは残り続けるので、削除したい場合 -->
docker volume rm <volume_name>
<!-- 自動で名前振られたVolumeを削除 -->
docker volume rm $(docker volume ls -qf dangling=true)