% rebase('base.tpl', page='Journal')
<table class="table">
  <tbody>
  % for (prio, time, comm, msg) in rows:
    <tr {{!'class="danger"' if prio <= 3 else ''}}>
      <td>{{time}}</td>
      <td>{{comm}}</td>
      <td>{{msg}}</td>
    </tr>
  % end
  </tbody>
</table>
