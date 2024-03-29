<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>STARTX Webserver container</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">

    </head>
    <body>
        <nav class="navbar navbar-inverse navbar-fixed-top">
            <div class="container">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href="#"><span>STARTX</span> PHP Webserver</a>
                </div>
            </div>
        </nav>
        <div class="jumbotron">
            <div class="container">
                <h1>Congratulation !</h1>
                <p>You are actually running an apache webserver + php <?php echo phpversion(); ?>  running under the latest fedora release. For more information about this container and how to add your content instead of this message, please read the following links.</p>
                <p>
                    <a class="btn btn-primary btn-lg"href="https://gitlab.com/startx1/containers/tree/master/Services/php" target="_blank" role="button">See this container Dockerfile</a>
                    <a class="btn btn-primary btn-lg"href="https://gitlab.com/startx1/containers" target="_blank" role="button">STARTX github docker images repository</a>
                    <a class="btn btn-primary btn-lg"href="https://registry.hub.docker.com/u/startx/" target="_blank" role="button">STARTX Dockerhub profile</a>
                </p>
            </div>
        </div>
        <hr>
        <?php phpinfo(); ?>
        <footer>
            <p>&copy; <?php echo date('Y'); ?> - <a href="https://github.com/startxfr" target="_blank">STARTX</a> - <a href="https://www.startx.fr" target="_blank">STARTX Dev Team</a></p>
        </footer>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
    </body>
</html>