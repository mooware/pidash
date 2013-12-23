% rebase('base.tpl', page='Home')
<h1>Home</h1>

<form class="form-inline" action="/command" method="post">
% for cmd in ['HALT', 'POWEROFF', 'REBOOT']:
  <button type="submit" class="btn btn-large btn-danger" name="command" value="{{cmd}}">{{cmd}}</button>
% end
</form>

<h3>Uptime</h3>
<p>{{uptime}}</p>
