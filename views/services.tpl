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
      <td><button type="button" class="btn btn-sm btn-default">{{'STOP' if is_running else 'START'}}</button></td>
    </tr>
  % end
  </tbody>
</table>
