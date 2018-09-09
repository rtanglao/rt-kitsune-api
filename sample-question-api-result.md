* the following is the output of: https://github.com/rtanglao/rt-kitsune-api/blob/master/testAPI.rb specifically:
```ruby
ap questions["results"][0], { :html => true}
```
## questions
* beginning of questions json

```json
{
  "count" => 360927,
   "next" => 
   "https://support.mozilla.org/api/2/question/?format=json&locale=en-US&ordering=%2Bcreated&page=2&product=firefox",
   "previous" => nil,
}
```


## results i.e. questions["results"]
<pre>{
                &quot;answers&quot;<kbd style="color:slategray"> =&gt; </kbd>[],
                &quot;content&quot;<kbd style="color:slategray"> =&gt; </kbd><kbd style="color:brown">&quot;&lt;p&gt;Restart computer to reestablish icon? If so, why did it vanish in the first place? Security or safety of using computers is called into\nquestion every time these unexplained occurrences take place. Thank you for your reply.\n&lt;/p&gt;&quot;</kbd>,
                &quot;created&quot;<kbd style="color:slategray"> =&gt; </kbd><kbd style="color:brown">&quot;2018-09-09T03:39:25Z&quot;</kbd>,
                &quot;creator&quot;<kbd style="color:slategray"> =&gt; </kbd>{
            &quot;username&quot;<kbd style="color:slategray"> =&gt; </kbd><kbd style="color:brown">&quot;dhmaritime&quot;</kbd>,
        &quot;display_name&quot;<kbd style="color:slategray"> =&gt; </kbd><kbd style="color:red">nil</kbd>,
              &quot;avatar&quot;<kbd style="color:slategray"> =&gt; </kbd><kbd style="color:brown">&quot;https://secure.gravatar.com/avatar/f9429ac71701dfd74029fb9f60987ca5?s=48&amp;d=https%3A//static-media-prod-cdn.sumo.mozilla.net/static/sumo/img/avatar.png&quot;</kbd>
    },
                     &quot;id&quot;<kbd style="color:slategray"> =&gt; </kbd>1232941,
               &quot;involved&quot;<kbd style="color:slategray"> =&gt; </kbd>[
        <kbd style="color:white">[0] </kbd>{
                &quot;username&quot;<kbd style="color:slategray"> =&gt; </kbd><kbd style="color:brown">&quot;dhmaritime&quot;</kbd>,
            &quot;display_name&quot;<kbd style="color:slategray"> =&gt; </kbd><kbd style="color:red">nil</kbd>,
                  &quot;avatar&quot;<kbd style="color:slategray"> =&gt; </kbd><kbd style="color:brown">&quot;https://secure.gravatar.com/avatar/f9429ac71701dfd74029fb9f60987ca5?s=48&amp;d=https%3A//static-media-prod-cdn.sumo.mozilla.net/static/sumo/img/avatar.png&quot;</kbd>
        }
    ],
            &quot;is_archived&quot;<kbd style="color:slategray"> =&gt; </kbd><kbd style="color:red">false</kbd>,
              &quot;is_locked&quot;<kbd style="color:slategray"> =&gt; </kbd><kbd style="color:red">false</kbd>,
              &quot;is_solved&quot;<kbd style="color:slategray"> =&gt; </kbd><kbd style="color:red">false</kbd>,
                &quot;is_spam&quot;<kbd style="color:slategray"> =&gt; </kbd><kbd style="color:red">false</kbd>,
               &quot;is_taken&quot;<kbd style="color:slategray"> =&gt; </kbd><kbd style="color:red">false</kbd>,
            &quot;last_answer&quot;<kbd style="color:slategray"> =&gt; </kbd><kbd style="color:red">nil</kbd>,
                 &quot;locale&quot;<kbd style="color:slategray"> =&gt; </kbd><kbd style="color:brown">&quot;en-US&quot;</kbd>,
               &quot;metadata&quot;<kbd style="color:slategray"> =&gt; </kbd>[
        <kbd style="color:white">[0] </kbd>{
             &quot;name&quot;<kbd style="color:slategray"> =&gt; </kbd><kbd style="color:brown">&quot;category&quot;</kbd>,
            &quot;value&quot;<kbd style="color:slategray"> =&gt; </kbd><kbd style="color:brown">&quot;other&quot;</kbd>
        },
        <kbd style="color:white">[1] </kbd>{
             &quot;name&quot;<kbd style="color:slategray"> =&gt; </kbd><kbd style="color:brown">&quot;ff_version&quot;</kbd>,
            &quot;value&quot;<kbd style="color:slategray"> =&gt; </kbd><kbd style="color:brown">&quot;62.0&quot;</kbd>
        },
        <kbd style="color:white">[2] </kbd>{
             &quot;name&quot;<kbd style="color:slategray"> =&gt; </kbd><kbd style="color:brown">&quot;os&quot;</kbd>,
            &quot;value&quot;<kbd style="color:slategray"> =&gt; </kbd><kbd style="color:brown">&quot;Windows 10&quot;</kbd>
        },
        <kbd style="color:white">[3] </kbd>{
             &quot;name&quot;<kbd style="color:slategray"> =&gt; </kbd><kbd style="color:brown">&quot;plugins&quot;</kbd>,
            &quot;value&quot;<kbd style="color:slategray"> =&gt; </kbd><kbd style="color:brown">&quot;* Shockwave Flash 30.0 r0&quot;</kbd>
        },
        <kbd style="color:white">[4] </kbd>{
             &quot;name&quot;<kbd style="color:slategray"> =&gt; </kbd><kbd style="color:brown">&quot;product&quot;</kbd>,
            &quot;value&quot;<kbd style="color:slategray"> =&gt; </kbd><kbd style="color:brown">&quot;desktop&quot;</kbd>
        },
        <kbd style="color:white">[5] </kbd>{
             &quot;name&quot;<kbd style="color:slategray"> =&gt; </kbd><kbd style="color:brown">&quot;useragent&quot;</kbd>,
            &quot;value&quot;<kbd style="color:slategray"> =&gt; </kbd><kbd style="color:brown">&quot;Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:62.0) Gecko/20100101 Firefox/62.0&quot;</kbd>
        }
    ],
                   &quot;tags&quot;<kbd style="color:slategray"> =&gt; </kbd>[
        <kbd style="color:white">[0] </kbd>{
            &quot;name&quot;<kbd style="color:slategray"> =&gt; </kbd><kbd style="color:brown">&quot;Firefox 62.0&quot;</kbd>,
            &quot;slug&quot;<kbd style="color:slategray"> =&gt; </kbd><kbd style="color:brown">&quot;firefox-620&quot;</kbd>
        },
        <kbd style="color:white">[1] </kbd>{
            &quot;name&quot;<kbd style="color:slategray"> =&gt; </kbd><kbd style="color:brown">&quot;other&quot;</kbd>,
            &quot;slug&quot;<kbd style="color:slategray"> =&gt; </kbd><kbd style="color:brown">&quot;other&quot;</kbd>
        },
        <kbd style="color:white">[2] </kbd>{
            &quot;name&quot;<kbd style="color:slategray"> =&gt; </kbd><kbd style="color:brown">&quot;desktop&quot;</kbd>,
            &quot;slug&quot;<kbd style="color:slategray"> =&gt; </kbd><kbd style="color:brown">&quot;desktop&quot;</kbd>
        },
        <kbd style="color:white">[3] </kbd>{
            &quot;name&quot;<kbd style="color:slategray"> =&gt; </kbd><kbd style="color:brown">&quot;Windows 10&quot;</kbd>,
            &quot;slug&quot;<kbd style="color:slategray"> =&gt; </kbd><kbd style="color:brown">&quot;windows-10&quot;</kbd>
        }
    ],
            &quot;num_answers&quot;<kbd style="color:slategray"> =&gt; </kbd>0,
    &quot;num_votes_past_week&quot;<kbd style="color:slategray"> =&gt; </kbd>1,
              &quot;num_votes&quot;<kbd style="color:slategray"> =&gt; </kbd>1,
                &quot;product&quot;<kbd style="color:slategray"> =&gt; </kbd><kbd style="color:brown">&quot;firefox&quot;</kbd>,
               &quot;solution&quot;<kbd style="color:slategray"> =&gt; </kbd><kbd style="color:red">nil</kbd>,
              &quot;solved_by&quot;<kbd style="color:slategray"> =&gt; </kbd><kbd style="color:red">nil</kbd>,
            &quot;taken_until&quot;<kbd style="color:slategray"> =&gt; </kbd><kbd style="color:red">nil</kbd>,
               &quot;taken_by&quot;<kbd style="color:slategray"> =&gt; </kbd><kbd style="color:red">nil</kbd>,
                  &quot;title&quot;<kbd style="color:slategray"> =&gt; </kbd><kbd style="color:brown">&quot;The firefox icon vanished for no reason. Had to open Firefox from computer list of programs. How to get it back without reloading entire program?&quot;</kbd>,
                  &quot;topic&quot;<kbd style="color:slategray"> =&gt; </kbd><kbd style="color:brown">&quot;other&quot;</kbd>,
             &quot;updated_by&quot;<kbd style="color:slategray"> =&gt; </kbd><kbd style="color:red">nil</kbd>,
                &quot;updated&quot;<kbd style="color:slategray"> =&gt; </kbd><kbd style="color:brown">&quot;2018-09-09T03:39:25Z&quot;</kbd>
}</pre>
