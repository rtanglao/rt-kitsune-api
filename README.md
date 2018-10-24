# rt-kitsune-api
roland's experiments with kitsune api for sumo aka support.mozilla.org

## 23october2018 hunspell stemmed ff60-62
* https://github.com/rtanglao/rt-kitsune-api/blob/master/VISUALIZATIONS/hunspell-ff60-ff61-ff62-1st-three-weeks-common-words.R

<br />

![hunspell stemmed ff60-62 1st 3 weeks](https://raw.githubusercontent.com/rtanglao/rt-kitsune-api/master/VISUALIZATIONS/hunspell-ff60-ff61-ff62-1st-three-weeks-common-words.png)

## 22october2018 ff60-62 1st 3 weeks non stemmed

* https://github.com/rtanglao/rt-kitsune-api/blob/master/VISUALIZATIONS/ff60-ff62-ff63-1st-three-weeks-common-words.r

<br />

![ff60-62 1st 3 weeks non stemmed](https://github.com/rtanglao/rt-kitsune-api/raw/master/VISUALIZATIONS/ff60-ff62-ff63-1st-three-weeks-common-words.png)

## 22october2018 snowball  stemmer applied to firefox 62 data

* https://github.com/rtanglao/rt-kitsune-api/blob/master/VISUALIZATIONS/hunspell-stemmer-firefox62-most-common-words-stop-words-removed-bar-graph.R erroneously produces "tri" (try? tries?) and even more unintelligible stems than hunwell)

<br />

![ff62-snowball-stemmer](https://github.com/rtanglao/rt-kitsune-api/raw/master/VISUALIZATIONS/snowball-stemmer-firefox62-most-common-words-stop-words-removed-bar-graph.png)

## 22october2018 hunwell stemmer applied to firefox 62 data

* https://github.com/rtanglao/rt-kitsune-api/blob/master/VISUALIZATIONS/hunspell-stemmer-firefox62-most-common-words-stop-words-removed-bar-graph.R erroneously produces "ha" (hang?) and "stall" (install?) and "aft" (not sure what this is!)

<br />

![ff62-hunspell-stemmer](https://github.com/rtanglao/rt-kitsune-api/raw/master/VISUALIZATIONS/hunspell-stemmer-firefox62-most-common-words-stop-words-removed-bar-graph.png)

## 21october2018 get firefox 60-62 first 3 weeks with firefoxversion in preparation for faceted plot

```bash
./print-csv-ff-desktop-questions-id-content-created-product-tags-title-topic-firefoxversion.rb \
2018 5 9 2018 5 29 60 \
created21october2018-ff60-9-29may2018-questions-id-content-created-product-tags-topic-firefoxvesrion.csv
./print-csv-ff-desktop-questions-id-content-created-product-tags-title-topic-firefoxversion.rb \
2018 6 26 2018 7 16 61 \
created21october2018-ff61-26june-16july-2018-questions-id-content-created-product-tags-topic-firefoxversion.csv
./print-csv-ff-desktop-questions-id-content-created-product-tags-title-topic-firefoxversion.rb \
2018 9 5 2018 9 25 62 \
created21october2018-ff62-5-25september-2018-questions-id-content-created-product-tags-topic-firefoxversion.csv
```

## 21october2018 get firefox 60 may 9, 2018 until firefox 62 end of 3rd week september 25, 2018
```bash
./print-csv-ff-desktop-questions-id-content-created-product-tags-title-topic.rb 2018 5 9 2018 9 25 9may-25september2018-ff-desktop-questions-id-content-created-product-tags-title-topic.csv
```

## 21october2018 running until may 5 to get ff60 questions
* try 1 hung in june 2018!
```bash
./get-sumo-firefox-questions-from-api.rb 2018 05 9 2> try2-21october2018-get_ff60_ff61_ff62_stderr.txt
```

## 20october2018 graph most common words with stopwords like ff,firefox, mozilla, browser, computer removed:
* https://github.com/rtanglao/rt-kitsune-api/blob/master/VISUALIZATIONS/firefox62-most-common-words-stop-words-removed-bar-graph.r
![created20october2018-stop-words-removed-firefox62-first-3-weeks-most-common-words](https://github.com/rtanglao/rt-kitsune-api/blob/master/VISUALIZATIONS/created20october2018-stop-words-removed-firefox62-first-3-weeks-most-common-words.png)

## 20october2018 graph most common words:
* https://github.com/rtanglao/rt-kitsune-api/blob/master/VISUALIZATIONS/firefox62-most-common-words-bar-graph.r
* output: https://www.flickr.com/photos/roland/44549267815/ (**in a future version, need to remove stopwords like firefox, ff62, ff, numbers, etc**), also on github:
![created20october2018-firefox62-first-3-weeks-most-common-words](https://github.com/rtanglao/rt-kitsune-api/raw/master/VISUALIZATIONS/created20october2018-stop-words-removed-firefox62-first-3-weeks-most-common-words.png)

## 20october2018 update csv file

```bash
cd /home/rtanglao/GIT/rt-kitsune-api/VISUALIZATIONS
 ../print-csv-ff-desktop-questions-id-content-created-product-tags-title-topic.rb \
 2018 9 5 2018 9 25 \
 created-20october2018-5-25september-ff-desktop-questions-id-content-created-product-tags-title-topic.csv
```

## 15october2018
### 15october2018 num_votes

* find out how many people have voted for a question and display the top 10 and open them in the default browser:

```bash
export BROWSER='/mnt/c/Program\ Files/Mozilla\ Firefox/firefox.exe'
./top-10-num-votes.rb 2018 9 5 2018 9 25 2>05-25september2018-top-10-votes.stderr.text
```

## 02october2018
### 02october2018 find out how many questions have a certain tag

```bash
./print-tag.rb 2018 9 5 2018 9 25 bookmarkdescriptionremoval # yields 53 questions!
```

## 01october2018

### 01october2018 get csv for word cloud

output:

https://github.com/rtanglao/rt-kitsune-api/blob/master/VISUALIZATIONS/5-25september-ff-desktop-questions-id-content-created-product-tags-title-topic.csv

```bash
 ./print-csv-ff-desktop-questions-id-content-created-product-tags-title-topic.rb \
 2018 9 5 2018 9 25 \
 5-25september-ff-desktop-questions-id-content-created-product-tags-title-topic.csv
```
### 01october2018 variety at level 1

```bash
 mongo ff62questions --eval "var collection = 'questions', maxDepth=1, lastValue = true" variety.js
```

```
+-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| key                 | types                    | occurrences | percents | lastValue                                                                                                                                               |
| ------------------- | ------------------------ | ----------- | -------- | ------------------------------------------------------------------------------------------------------------------------------------------------------- |
| _id                 | ObjectId                 |        1866 |    100.0 | 5baf13e01cb741f05c219400                                                                                                                                |
| answers             | Array                    |        1866 |    100.0 | [Array]                                                                                                                                                 |
| content             | String                   |        1866 |    100.0 | <p>Desktop computer.  Now no browser.   ????
</p>                                                                                                       |
| created             | Date                     |        1866 |    100.0 |                                                                                                                                           1537910207000 |
| creator             | Object                   |        1866 |    100.0 | [Object]                                                                                                                                                |
| id                  | Number                   |        1866 |    100.0 |                                                                                                                                                 1235288 |
| involved            | Array                    |        1866 |    100.0 | [Array]                                                                                                                                                 |
| is_archived         | Boolean                  |        1866 |    100.0 | false                                                                                                                                                   |
| is_locked           | Boolean                  |        1866 |    100.0 | false                                                                                                                                                   |
| is_solved           | Boolean                  |        1866 |    100.0 | false                                                                                                                                                   |
| is_spam             | Boolean                  |        1866 |    100.0 | false                                                                                                                                                   |
| is_taken            | Boolean                  |        1866 |    100.0 | false                                                                                                                                                   |
| last_answer         | null (152),Number (1714) |        1866 |    100.0 | [null]                                                                                                                                                  |
| locale              | String                   |        1866 |    100.0 | en-US                                                                                                                                                   |
| metadata            | Array                    |        1866 |    100.0 | [Array]                                                                                                                                                 |
| num_answers         | Number                   |        1866 |    100.0 | [Number]                                                                                                                                                |
| num_votes           | Number                   |        1866 |    100.0 |                                                                                                                                                       1 |
| num_votes_past_week | Number                   |        1866 |    100.0 |                                                                                                                                                       1 |
| product             | String                   |        1866 |    100.0 | firefox                                                                                                                                                 |
| solution            | null (1412),Number (454) |        1866 |    100.0 | [null]                                                                                                                                                  |
| solved_by           | null (1412),Object (454) |        1866 |    100.0 | [null]                                                                                                                                                  |
| tags                | Array                    |        1866 |    100.0 | [Array]                                                                                                                                                 |
| taken_by            | null                     |        1866 |    100.0 | [null]                                                                                                                                                  |
| taken_until         | null                     |        1866 |    100.0 | [null]                                                                                                                                                  |
| title               | String                   |        1866 |    100.0 | Been getting update message for a while now.  I always choose update but apparently its not updating.  Now Firefox won't come up at all.  I need help!! |
| topic               | String                   |        1866 |    100.0 | basic-browsing-firefox                                                                                                                                  |
| updated             | String                   |        1866 |    100.0 | 2018-09-25T21:16:47Z                                                                                                                                    |
| updated_by          | null (1722),Object (144) |        1866 |    100.0 | [null]                                                                                                                                                  |
+-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
```


### 01october2018 use variety to see what should go into a csv file

```bash
cd
cd GIT
git clone https://github.com/variety/variety.git
cd variety
sudo npm install
mongo ff62questions --eval "var collection = 'questions'" variety.js
```
```
+------------------------------------------------------------------------------------------+
| key                      | types                     | occurrences | percents            |
| ------------------------ | ------------------------- | ----------- | ------------------- |
| _id                      | ObjectId                  |        1866 | 100.000000000000000 |
| answers                  | Array                     |        1866 | 100.000000000000000 |
| content                  | String                    |        1866 | 100.000000000000000 |
| created                  | Date                      |        1866 | 100.000000000000000 |
| creator                  | Object                    |        1866 | 100.000000000000000 |
| creator.avatar           | String                    |        1866 | 100.000000000000000 |
| creator.display_name     | null (1721),String (145)  |        1866 | 100.000000000000000 |
| creator.username         | String                    |        1866 | 100.000000000000000 |
| id                       | Number                    |        1866 | 100.000000000000000 |
| involved                 | Array                     |        1866 | 100.000000000000000 |
| involved.XX.avatar       | String                    |        1866 | 100.000000000000000 |
| involved.XX.display_name | null (1724),String (1708) |        1866 | 100.000000000000000 |
| involved.XX.username     | String                    |        1866 | 100.000000000000000 |
| is_archived              | Boolean                   |        1866 | 100.000000000000000 |
| is_locked                | Boolean                   |        1866 | 100.000000000000000 |
| is_solved                | Boolean                   |        1866 | 100.000000000000000 |
| is_spam                  | Boolean                   |        1866 | 100.000000000000000 |
| is_taken                 | Boolean                   |        1866 | 100.000000000000000 |
| last_answer              | null (152),Number (1714)  |        1866 | 100.000000000000000 |
| locale                   | String                    |        1866 | 100.000000000000000 |
| metadata                 | Array                     |        1866 | 100.000000000000000 |
| num_answers              | Number                    |        1866 | 100.000000000000000 |
| num_votes                | Number                    |        1866 | 100.000000000000000 |
| num_votes_past_week      | Number                    |        1866 | 100.000000000000000 |
| product                  | String                    |        1866 | 100.000000000000000 |
| solution                 | null (1412),Number (454)  |        1866 | 100.000000000000000 |
| solved_by                | null (1412),Object (454)  |        1866 | 100.000000000000000 |
| tags                     | Array                     |        1866 | 100.000000000000000 |
| tags.XX.name             | String                    |        1866 | 100.000000000000000 |
| tags.XX.slug             | String                    |        1866 | 100.000000000000000 |
| taken_by                 | null                      |        1866 | 100.000000000000000 |
| taken_until              | null                      |        1866 | 100.000000000000000 |
| title                    | String                    |        1866 | 100.000000000000000 |
| topic                    | String                    |        1866 | 100.000000000000000 |
| updated                  | String                    |        1866 | 100.000000000000000 |
| updated_by               | null (1722),Object (144)  |        1866 | 100.000000000000000 |
| metadata.XX.name         | String                    |        1865 |  99.946409431939983 |
| metadata.XX.value        | String                    |        1865 |  99.946409431939983 |
| solved_by.avatar         | String                    |         454 |  24.330117899249732 |
| solved_by.display_name   | String (377),null (77)    |         454 |  24.330117899249732 |
| solved_by.username       | String                    |         454 |  24.330117899249732 |
| updated_by.avatar        | String                    |         144 |   7.717041800643087 |
| updated_by.display_name  | null (78),String (66)     |         144 |   7.717041800643087 |
| updated_by.username      | String                    |         144 |   7.717041800643087 |
+------------------------------------------------------------------------------------------+
```

### 01october2018 fix operating system graph to clearly label lines using r package directlabels
* code: 
  * https://github.com/rtanglao/rt-kitsune-api/blob/master/VISUALIZATIONS/01october2018-ff62-operating-system-directlabels.r
* output:

![01october2018-ff62-operating-system-directlabels-Rplot13.png](https://github.com/rtanglao/rt-kitsune-api/raw/master/VISUALIZATIONS/01october2018-ff62-operating-system-directlabels-Rplot13.png)

## 29september2018
## 29september2018 visualizations

```bash
mkdir VISUALIZATIONS
cd !$
./ten-pixel-zazzle-2100-1800.rb 2018 9 5 2018 9 25 tenpixel.png
./ten-pixel-sequential-purple-zazzle-2100-1800.rb 2018 9 5 2018 9 25 ff62-5-25September2018-ten-pixel-sequential-purple-ish.png
./ten-pixel-single-red-zazzle-2100-1800.rb 2018 9 5 2018 9 25 ff62-5-25September2018-ten-pixel-single-red.png
./ten-pixel-twenty-four-pink-zazzle-2100-1800.rb 2018 9 5 2018 9 25 ff62-5-25September2018-ten-pixel-twenty-four-pink.png
```

## 28september2018
### 28sptember2018 backup the database from september 26

```bash
mongodump --archive=26september2018ff62questions.gz --gzip --db ff62questions --collection questions
```
 
## 27september2018

## 27september2018 run r code to get line graph of os

```r
library(tidyverse)
week1_to_week3_os_tags <-
  read_csv(
    "https://raw.githubusercontent.com/rtanglao/rt-kitsune-api/master/FF62_WEEK1_TO_3/26september2018-week1-week3-weeknumber-tags.csv") %>% 
  filter(
    grepl("^windows-", tag) |
    grepl("^mac-os", tag) |
    (tag == "linux")) %>%
  mutate(os=ifelse(grepl("^windows-", tag), "windows", tag)) %>% 
  mutate(os=ifelse(grepl("^mac-os", tag), "mac-os", tag)) %>% 
  filter(tag != "windows-active-directory")
week1_to_week3_os_plot <-
  ggplot(data=week1_to_week3_os_tags, aes(x=week, fill=os))
week1_to_week3_os_plot = week1_to_week3_os_plot + 
  geom_bar(stat="bin", bins = 3,
  position="dodge")
week1_to_week3_os_line_plot <-
  ggplot(data=week1_to_week3_os_tags, aes(
    x=week, fill=os, colour = os))
week1_to_week3_os_line_plot = week1_to_week3_os_line_plot + 
  geom_line(stat="bin", bins = 3) + 
  scale_color_manual(values = c(
    'windows-10' = 'green',
    'linux' = 'purple',
    'mac-os' = 'orange',
    'windows-7' = 'pink',
    'windows-8' = 'blue',
    'windows-81' = 'brown',
    'windows-server-2016' = 'magenta',
    'windows-vista' = 'black',
    'windows-xp' = 'dark green')) +
  labs(color = 'FF62 OS 5-25Sep2018')
```

Graph:

![Firefox 62 Desktop Operating System SUMO Questions 5-25 September2018.png
](https://github.com/rtanglao/rt-kitsune-api/raw/master/FF62_WEEK1_TO_3/Firefox%2062%20Desktop%20Operating%20System%20SUMO%20Questions%205-25%20September2018.png)

### 27september2018 run r code to get tag graph

* https://github.com/rtanglao/rt-kitsune-api/blob/master/FF62_WEEK1_TO_3/ff62-desktop-5-25september2018-gt10-common-tags-removed.r

Output:

![ff62-week1-week3-5-25september2018-gt10-tags-os-firefox-tags-removed.png](https://github.com/rtanglao/rt-kitsune-api/raw/master/FF62_WEEK1_TO_3/ff62-week1-week3-5-25september2018-gt10-tags-os-firefox-tags-removed.png)

## 26september2018

### 26september2018 run r code to get the Operating System graph

* https://github.com/rtanglao/rt-kitsune-api/blob/master/FF62_WEEK1_TO_3/ff62-desktop-operating-system-first-3-weeks.r

Output:

![operating-systems-ff62-desktop-first3weeks-5-25september2018.png](https://github.com/rtanglao/rt-kitsune-api/raw/master/FF62_WEEK1_TO_3/operating-systems-ff62-desktop-first3weeks-5-25september2018.png)

### 26september2018 get the tags by week

```bash
./print-csv-tags-unixtime-weeknumber.rb 2018 9 5 \
2018 9 11 1 >FF62_WEEK1_TO_3/26september2018-tags-05-11september2018.csv
./print-csv-tags-unixtime-weeknumber.rb 2018 9 12 \
 2018 9 18 2 >FF62_WEEK1_TO_3/26september2018-tags-12-18september2018.csv
./print-csv-tags-unixtime-weeknumber.rb 2018 9 19 \
 2018 9 25 3 >FF62_WEEK1_TO_3/26september2018-tags-19-25september2018.csv
cat 26september2018-tags-05-11september2018.csv \
26september2018-tags-12-18september2018.csv \
26september2018-tags-19-25september2018.csv > 26september2018-week1-week3-weeknumber-tags.csv
vi 26september2018-week1-week3-weeknumber-tags.csv and remove the headers at beginning of week 2 and week 3
```

### 26september2018 get the tags
```bash
mkdir FF62_WEEK1_TO_3
 ./print-csv-tags-unixtime.rb 2018 9 5 2018 9 25 >FF62_WEEK1_TO_3/26september2018-tags-05-25september2018.csv
```

## 22september2018 
### 22september2018 how to open browser from wsl i.e. my previous blog post was wrong, no selenium server required
* blog post: http://rolandtanglao.com/2018/09/22/p1-launchy-works-on-wsl-if-you-set-browser-environment-variable/

* in bash:
```bash
export BROWSER='/mnt/c/Program\ Files/Mozilla\ Firefox/firefox.exe'
```
* and then in ruby launchy just works:
```ruby
require 'launchy'
Launchy.open("https://support.mozilla.org")
```

## 17september201!

### 17september2018 mongodb query to get questions for Thursday13Sept-Sat15Sept2018

```json
{
    "created": {
        "$gte": ISODate("2018-09-13T00:00:00-07:00"),
        "$lt" : ISODate("2018-09-16T00:00:00-07:00")
    }
}
```

### 17september2018 how to compute an operating system tag
* the following code is from [tim smith](https://github.com/tdsmith), thanks Tim!

```r
os_tags <-
read_csv("
  https://raw.githubusercontent.com/rtanglao/rt-kitsune-api/master/FF62_WEEK1/16september2018-tags-5-11september2018.csv") 
  %>%
    filter(
      grepl("^windows-", tag) |
             (tag == "mac-os") |
             (tag == "linux")) 
  %>%
 mutate(os=ifelse(grepl("^windows-", tag), "windows", tag))
```
### 17september2018 how to read a file of tags and collapse

* test.txt has:
```
rolandff62experiment
ff62

```

```r
test.txt <- read.table("machine-tags.txt") # with new line at end of file!
> paste(test.txt[,1],collapse="|")
[1] "rolandff62experiment|ff62"
```


## 16september2018

### 16september2018 remove machine and operating system tags raw R Studio

* the following can be done more concisely with:
```  filter(str_detect(rowname, "Merc|Toy"))```
see: https://sebastiansauer.github.io/dplyr_filter/ for full details

```r
tags_gt10_remove_common_tags <-
tags_count_gt_10 %>%
filter(tag != "desktop" &
tag != "escalate" &
tag != "beta" &
tag != "esr" &
tag != "firefox-520" &
tag != "firefox-600" &
tag != "firefox-610" &
tag != "firefox-6102" &
tag != "firefox-620" &
tag != "firefox-630" &
tag != "linux" &
tag != "mac-os" &
tag != "needsinfo" &
tag != "other" &
tag != "rolandff62experiment" &
tag != "windows-10" &
tag != "windows-7" &
tag != "windows-81" &
tag != "windows-xp" )
View(tags_with_counts)
View(tags_gt10_remove_common_tags)
p3 = ggplot(data=tags_gt10_remove_common_tags, aes(x=tag, y=n))
p3 = p3 + geom_bar(stat = "identity")
p3 = p3 + theme(axis.text.x = element_text(angle = 90, hjust = 1))
p3
```

Output:

![Week 1 Firefox 62 Desktop SUMO Forum desktop tags with all operating system tags removed](https://github.com/rtanglao/rt-kitsune-api/blob/master/FF62_WEEK1/Operating%20System%20tags%20removed%20for%20the%20first%20week%20of%20Firefox%20Desktop%2062%20i.e.%20September%205-11Rplot02.png)


### 16september2018 raw R Studio

```r
install.packages("ggplot2")
library(ggplot2)
tags = read.csv(file = "https://raw.githubusercontent.com/rtanglao/rt-kitsune-api/master//FF62_WEEK1/16september2018-tags-5-11september2018.csv", stringsAsFactors = F)
p = ggplot(data=tags, aes(x=tag), stat="count")
p = ggplot(data=tags, aes(x=tag))
p= p + geom_bar(stat="count"
p
p= p + geom_bar(stat="count")
p
tags_with_counts <-
tags %>%
group_by(tag) %>%
count()
install.packages("tidyverse")
library(tidyverse)
tags_with_counts <-
tags %>%
group_by(tag) %>%
count()
tags_count_gt_10 <-
tags_with_counts %>%
filter(n >10)
p2 = ggplot(data=tags_count_gt_10, aes(x=tags))
p2 = p2 + geom_bar()
p2
p2 = p2 + geom_bar(stat="identity")
p2
tags_count_gt_10 <- tags_count_gt_10 %>% arrange(n)
p2 = ggplot(data=tags_count_gt_10, aes(x=tag))
p2 = p2 + geom_bar()
p2 = p2 + geom_bar(stat="identity")
p2 = p2 + geom_bar()
p2 = ggplot(data=tags_count_gt_10, aes(x=tag))
p2 = p2 + geom_bar(stat="identity")
p2 = ggplot(data=tags_count_gt_10, aes(x=tag, y=n))
p2 = p2 + geom_bar(stat="identity")
p2 = p2 + theme(axis.text.x = element_text(angle = 90, hjust = 1))
p2
```

Output:

![ All SUMO AAQ tags for the first week of Firefox Desktop 62 i.e. September 5-11, 2018](https://github.com/rtanglao/rt-kitsune-api/blob/master//FF62_WEEK1/sumo-firefox-desktop-62-week1-05-11september2018-all-tags-count-gt-10-Rplot02.png)

### 16september2018 get tags for week 1 of firefox 62 for desktop

```bash
./print-csv-tags-unixtime.rb 2018 9 5 2018 9 11 >16september2018-tags-5-11september2018.csv
```


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
