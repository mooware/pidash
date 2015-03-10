% rebase('base.tpl', page='Services')
<table class="table">
  <thead>
  % for field in header:
    <th>{{field}}</th>
  % end
  <th></th>
  </thead>
  <tbody>
  % for (is_failed, is_running, desc, unit, active, sub) in rows:
    <tr id='{{unit}}' {{!'class="danger"' if is_failed else ''}}>
      <td>{{desc}}</td>
      <td>{{unit}}</td>
      <td>{{active}}</td>
      <td>{{sub}}</td>
      <td>
        <form action="/services/command" method="post">
          % if is_running:
          %   command = 'STOP'
          % else:
          %   command = 'START'
          % end
          <input type="hidden" name="unit" value="{{unit}}"></input>
          <input type="hidden" name="command" value="{{command.lower()}}"></input>
          <button type="submit" class="btn btn-sm btn-cmd {{'btn-danger' if is_running else 'btn-success'}}">
            {{command}}
          </button>
        </form>
      </td>
    </tr>
  % end
  </tbody>
</table>
