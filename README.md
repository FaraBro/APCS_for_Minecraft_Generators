# Links
[Documentation](/doc)  
[LICENSE](#LICENSE)  
[Source Code](/src)  
[Update Log](/update-log.md)  

[README English (US)](#en_US)  
[README Russian (RU)](#ru_RU)  

# en_US

## Links
[Documentation](/doc/en_US/README.md)  
[Source Code](/src)  
[Update Log](/update-log.md)  

## About APCS
This APCS is ~~fully bullshit~~ a system designed to control generators.  
To run the code, you will need a Lua emulator similar to [OpenComputers](https://github.com/MightyPirates/OpenComputers).  
Currently, only generators and storage units from the [NTM](https://github.com/HbmMods/Hbm-s-Nuclear-Tech-GIT) are supported.  
Tested and working on versions:
- Minecraft: v1.7.10
- Lua: v5.3
- OpenComputers: v1.8.10
- NTM: v1.0.27 X5860

## How to install?
Simply find a way to download the code onto a disk in OpenComputers, without installing an OS onto it.

### How?!
Just do it somehow. Alright...
- You can go to the game directory; there, you’ll find a saves folder. Inside, look for your world (by its name), and within that, you’ll see an opencomputers folder containing disks (identified by their addresses). Just drag your code in there.
If a disk address folder is missing, you can either create one manually (which is time-consuming), disable file buffering in the OpenComputers configuration, or try downloading something to the disk—this will cause the folder to appear (just don’t forget to delete that "something" afterward).
- If you’re on a server, knowing how to use the OpenOS terminal will come in handy. Third-party programs might also be useful. Essentially, you can create files within `mnt/*disk address (at least the first few characters)/*`, paste your code into them, and repeat this for every file. Is it slow? But it works!

## For Contributors
If you’ve genuinely decided to modify the code and contribute to the project, then... go ahead and publish it -- just please don’t change the license.  
[LICENSE](#LICENSE)  

# ru_RU

## Ссылки
[Документация](/doc/ru_RU/README.md)  
[Исходный код](/src)  
[Лог обновлений](/update-log.md)  

## О APCS
Данная APCS является ~~полной хренью~~ штукой, которая контролирует генераторы.  
Для запуска кода вам потребуется любой эмулятор Lua кода, который похож на [OpenComputers](https://github.com/MightyPirates/OpenComputers)  
На данный момент поддерживаются только генераторы и хранилища из мода [NTM](https://github.com/HbmMods/Hbm-s-Nuclear-Tech-GIT)  
Протестировано и работает на версиях:
- Minecraft: v1.7.10
- Lua: v5.3
- OpenComputers: v1.8.10
- NTM: v1.0.27 X5860

## Как установить?
Просто каким-нибудь образом скачайте код на диск из OpenComputers без установки OS на него.

### Как?
Просто как-нибудь. Ладно...
- Можете перейти в директорию игры, там saves будет, внутри будет ваш мир (его название), а внутри него папка opencomputers с дисками (их адресами) перетащите код туда.
Если нет адреса диска либо создайте папку с адресом диска (что долго), либо отключите буферизацию файлов в конфиге OpenComputers, либо попытайтесь скачать туда что-то и диск появится (не забудьте удалить это *что-то*)
- Если вы на сервере, то знания как пользоваться терминалом OpenOS вам в помощь. А ну и сторонние программки вам могут тоже помощь. Просто можете создавать файлы в `mnt/*адрес диска (ну первые симв)*/` и там вставлять код и так каждый файл. Что медленно? Но работает!

## Для Contributors
Если вы реально решили изменить код и внести вклад в проект, то... публикуйте, только лицензию не меняйте please.  
[LICENSE](#LICENSE)  

# LICENSE

This software is made available under the terms of *either* of the licenses
found in LICENSE-APACHE or LICENSE-MIT. Contributions to this software are made
under the terms of *both* these licenses.
