# Home Work для интервью

Использовав Ansible и Vagrant
развернуть 3 виртуальной машины:

VM1 (4 ГБ ОЗУ, 3vCPU). установлен сервер FreeIpa и домен test.local, в домене пользователи user1 и user2
Использована роль ansible-galaxy ansible_freeipa
ip adrees: 192.168.56.10
web interface доступен по ссылке https://vm1.test.local/ipa/ui и по порту 8080 ~~- но пока не реализованно~~
По умолчанию логин:admin, пароль:freeipass


VM2 (3 ГБ ОЗУ, 2vCPU). установлен сервер Foreman, введен в качестве клиента на FreeIpa VM1
ip adrees: 192.168.56.20
web interface доступен по ссылке https://192.168.56.20 и по порту 8081 ~~- но пока не реализованно~~

VM3 (2 ГБ ОЗУ, 2vCPU). использован Dockerfile создающий сервер Zabbix
ip adrees: 192.168.56.30
web interface доступен по ссылке http://192.168.56.30/zabbix и по порту 8082 ~~- но пока не реализованно~~

## Оглавление

1. [Установка](#установка)
2. [Использование](#использование)
3. [Примеры](#примеры)
4. [Скрины](#скрины)

## Установка
  Разработка происходила на Ubuntu 22.04.3 LTS 
1. Клонируйте репозиторий: `git clone https://github.com/RuslanGalyaviev/home_work.git`
2. Установите зависимости: 'apt install ansible', 'apt install virtualbox', 'apt install vagrant'
3. Перейдите cd /home_work
4. Установите роли:
<pre>
```
ansible-galaxy collection install freeipa.ansible_freeipa
```
</pre> ansible-galaxy collection install freeipa.ansible_freeipa

## Использование

Виртуальные машины запускаются командой:

<pre>
```
vagrant up
```
</pre> 

Остановка:

<pre>
```
vagrant halt
```
</pre> 

Удаление виртулаьных машин:

<pre>
```
vagrant destroy
```
</pre> 

Подключение к виртуальным машинам осуществляеться через указанное имя хоста в нашем случае VM1, VM2 или VM3

<pre>
```
vagrant ssh VM1
```
</pre> 

VM1: 
По умолчанию логин:admin, пароль:freeipass
Пароль можно сменить на 65 строке файла playbook_vm1.yml
![image](https://github.com/RuslanGalyaviev/home_work/assets/38991333/3a53ba54-3ffc-4508-b28a-c8a1865fc13f)


VM2:
По умолчанию логин admin, а пароль выдаст после уставноки приложения foreman в терминале

![image](https://github.com/RuslanGalyaviev/home_work/assets/38991333/a199299d-0909-4182-9852-ad7be6b1b8ec)


## Примеры

Проверка статуса службы sssd:

![image](https://github.com/RuslanGalyaviev/home_work/assets/38991333/522adce4-d4cf-426d-9d43-14599e7d1087)

Проверка файла /etc/sssd/sssd.conf:

![image](https://github.com/RuslanGalyaviev/home_work/assets/38991333/0d1b8b59-2791-4805-8d27-dda36af29eae)

Возврашение информации о пользователе из домена:

![image](https://github.com/RuslanGalyaviev/home_work/assets/38991333/396d4b95-d7a3-4be8-b8b0-fdf1604c035c)

## Скрины рабочих VM
VM1:
