% rebase('base.tpl', page='Home')
% header = table[0]
% rows = table[1:]
<table class="table">
  <thead>
  % for field in header:
    <th>{{field}}</th>
  % end
  </thead>
  <tbody>
  % for row in rows:
    <tr>
    % for field in row:
      <td>{{field}}</td>
    % end
    </tr>
  % end
  </tbody>
</table>
