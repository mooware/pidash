% rebase('base.tpl', page='Home')

<h3>Links</h3>
<ul>
  <li><a href="http://{{host}}:9091/transmission/web/">Transmission</a></li>
</ul>

<h3>Commands</h3>
<form class="form-inline" action="/command" method="post">
% for cmd in ['HALT', 'POWEROFF', 'REBOOT']:
  <button type="submit" class="btn btn-large btn-danger" name="command" value="{{cmd}}">{{cmd}}</button>
% end
</form>

<h3>Uptime</h3>
<p>{{uptime}}</p>
