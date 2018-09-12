# rt-kitsune-api
roland's experiments with kitsune api for sumo aka support.mozilla.org

## 11September2018 answer API

* like the questionAPI this was discovered in [jscher2000's myq.html code](https://github.com/jscher2000/My-SuMo-Questions/blob/master/myq.html)!
* sample answer API code: https://github.com/rtanglao/rt-kitsune-api/blob/master/answerTestAPI.rb 
  * sample API json response: https://github.com/rtanglao/rt-kitsune-api/blob/master/sampleAnswerTestAPIoutput.md
* sample reply API code: https://github.com/rtanglao/rt-kitsune-api/blob/master/testAPI.rb
* API is:```https://support.mozilla.org/api/2/answer/?format=json&id=<question_id>``` 
  * where ```<question_id>``` is an integer question id!

## 10September2018 how to open tab in a browser (doesn't work in WSL)
* more info on why it doesn't work in WSL:
  * http://rolandtanglao.com/2018/09/09/p1-still-cannot-launch-firefox-from-wsl-without-lots-of-yakshaving/

```bash
./open-day-in-browser.rb 2018 9 10 2>11september2018-open-mon10september2018-sumo-firefox-quesions-stderr.txt
```

## 08September2018 how to run

## 08September2018 setup environment
```bash
cd ~/GIT/rt-kitsune-api
. setupDatabase
pushd ~/rtanglao/MONGODB_DATABASES/KITSUNE_QUESTIONS
# mongod --config --dbpath . & # on Windows Subystem for Linux
mongod --dbpath . & # on Mac OS X, should work on Windows, forgot to delete --config for some reason on Windows !
popd
```
## 08September2018 populate database
```bash
./get-sumo-firefox-questions-from-api.rb 2018 09 05
```
