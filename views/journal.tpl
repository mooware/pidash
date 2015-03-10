% rebase('base.tpl', page='Journal')
<table class="table">
  <tbody>
    <tr>
      <td colspan="3">
        <a href="?all=1">show all</a>
      </td>
    </tr>
  % ERR = 3
  % NOTICE = 5
  % for (prio, time, comm, msg) in rows:
    % if prio <= ERR:
    % hlclass = 'danger'
    % elif prio <= NOTICE:
    % hlclass = 'warning'
    % else:
    % hlclass = ''
    % end
    <tr class="{{hlclass}}">
      <td>{{time}}</td>
      <td>{{comm}}</td>
      <td>{{msg}}</td>
    </tr>
  % end
  </tbody>
</table>
