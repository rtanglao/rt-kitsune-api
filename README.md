# rt-kitsune-api
roland's experiments with kitsune api for sumo aka support.mozilla.org
## 08September2018 how to run

## 08September2018 setup environment
```bash
cd ~/GIT/rt-kitsune-api
. setupDatabase
pushd ~/rtanglao/MONGODB_DATABASES/KITSUNE_QUESTIONS
mongod --config --dbpath . &
popd
```
## 08September2018 populate database
```bash
./get-sumo-firefox-questions-from-api.rb 2018 09 05
```
