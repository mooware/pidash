% rebase('base.tpl', page='Journal')
<table class="table">
  <tbody>
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
