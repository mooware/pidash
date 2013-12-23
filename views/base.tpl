<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pi Dash</title>
    <link href="/css/bootstrap.min.css" rel="stylesheet">
    <link href="/css/pidash.css" rel="stylesheet">
  </head>

  <body>

    <div class="navbar navbar-inverse">
      <div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="/">Pi Dash</a>
        </div>
        <div class="collapse navbar-collapse">
          <ul class="nav navbar-nav">
          % for link in ['Home', 'Services', 'Journal']:
            <li {{!'class="active"' if link.lower() == page else ''}}><a href="/{{link.lower()}}">{{link}}</a></li>
          % end
          </ul>
        </div><!--/.nav-collapse -->
      </div>
    </div>

    <div class="container">
      {{!base}}
    </div><!-- /.container -->

    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="js/bootstrap.min.js"></script>
  </body>
</html>
