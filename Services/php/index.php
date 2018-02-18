<!DOCTYPE html>
<html>
    <head>
        <title>STARTX Webserver container</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <style>
            body {font-family: Helvetica, Arial, sans-serif;font-size: 14px;color: #333;padding: 0;margin: 0;}
            body > header { width: 900px; padding: 1em; margin: 0 auto 1em auto  }
            body > article {box-shadow: 5px 5px 10px  rgba(0,0,0,0.8); padding: 0 0 .5em 0; border-radius: 5px; width: 900px; margin: 2em auto 0 auto }
            body > footer { width: 900px; padding: 0em 0 1em 1em; margin: 1.1em auto 1em auto; color: white; font-size: .75em  }
            h1 { margin: 0; font-size: 3em; line-height: .8em }
            h2 { text-shadow: 1px 1px 1px rgba(0,0,0,0.25); font-size: 2.2em;margin: .2em;  }
            h3 { text-shadow: 1px 1px 0px rgba(255,255,255,1); font-size: 1.5em;margin: .2em;  }
            h4 {  font-size: 1.2em; margin: .2em; }
            p { font-size: 1em; margin: .5em .2em; }
            ul {
                padding-bottom: 1em;
                padding-left: 2em;
            }
            a {
                color: white;
                text-decoration: none;
                background: transparent !important;
            }
            body > header h1 { color: #000e44; text-shadow: 0 0 3px  rgb(255,255,255),  0 0 10px  rgba(255,255,255,1),  0 0 20px  rgba(255,255,255,0.6); float: left }
            body > header h1 span { color: #0c6f5e }
            body > header h2 { color: white; font-size: .7em; font-weight: normal; margin: 2.2em 0 0 1em; float: left }
            body > header h3 { color: #0c6f5e; margin: 0; font-size: 2em; float: right }
            article header { margin: 0;padding: .3em; box-shadow: 0 0 5px  rgba(0,0,0,0.9); border-radius: 5px 5px 0 0; width: 892px; }
            article h3 { display: inline; }
            article > details { margin: 1em; }


            body#error  { background-color : #533;}
            #error article { color : darkred; background-color : rgba(255,255,255,0.9); clear: both }
            #error article h2 { color : white; text-shadow: 0 0 2px white, 0 0 15px #600, 3px 3px 8px rgba(50,0,0,0.9); }
            #error article header { background-color : rgba(85,51,51,0.6); }
            #error h3, #error article a { color : #744; }
            #error article a:hover { color : #533; }
            #error pre.xdebug-var-dump {font-size:0.8em}

            body#answer  { background-color : #353 }
            #answer article { color : #575;background-color : rgba(255,255,255,0.9); clear: both }
            #answer article h2 { color : white; text-shadow: 0 0 2px rgba(11,45,11,0.9), 0 0 10px rgba(11,45,11,0.8); }
            #answer article header { background-color : rgba(51,85,51,0.6); }
            #answer h3, #answer article a { color : #686; }
            #answer article a:hover { color : #353; }
        </style>
    </head>
    <body id="answer">
        <header>
            <h1><span>STARTX</span> PHP Webserver</h1>
            <h3>Online</h3>
        </header>
        <article>
            <header>
                <h2>Congratulation !!!</h2>
            </header>
            <p>
                You are actually running an apache webserver + php running under the 26 fedora release. For more information about this container and how to add your content instead of this message, please read the following links.
            <ul>
                <li><a href="https://github.com/startxfr/docker-images/tree/fc26/Services/php" target="_blank">See this container Dockerfile</a></li>
                <li><a href="https://github.com/startxfr/docker-images" target="_blank">STARTX github docker images repository</a></li>
                <li><a href="https://registry.hub.docker.com/u/startx/" target="_blank">STARTX Dockerhub profile</a></li>
            </ul>
            <?php phpinfo(); ?>
        </p>
    </article>
    <footer><p>&copy; 2015 - <a href="https://github.com/startxfr" target="_blank">STARTX</a> - <a href="https://www.startx.fr" target="_blank">STARTX Dev Team</a></p></footer>
</body></html>