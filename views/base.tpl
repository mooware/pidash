<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    % if defined('page'):
    <title>Pi Dash - {{page}}</title>
    % else:
    <title>Pi Dash</title>
    % end
    <link href="/css/bootstrap.min.css" rel="stylesheet">
    <link href="/css/pidash.css" rel="stylesheet">
  </head>

  <body>

    <div class="navbar navbar-inverse">
      <div class="container">
        <div class="navbar-header">
          <a class="navbar-brand" href="/">Pi Dash</a>
        </div>
        <div>
          <ul class="nav navbar-nav">
          % for link in ['Services', 'Journal']:
            <li class="{{'active' if link.lower() == page else ''}}"><a href="/{{link.lower()}}">{{link}}</a></li>
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
