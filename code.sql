insert into itens_pedido (id_produto, qtd, id_pedido, id_itens_pedido)
values (1, 14, 2, 5);
delete
from itens_pedido
WHERE itens_pedido.id_itens_pedido = 5;
select *
from pedido;

select *
from itens_pedido;



insert into pedido (id_pedido, data, id_cliente)
values (2, SYSDATE(), 1);

select *
from produto;


update pedido
set vl_total = (select sum(qtd * valor)
                from itens_pedido itens,
                     produto prod
                where itens.id_produto = prod.id_produto
                  and itens.id_pedido = pedido.id_pedido);


CREATE TRIGGER pedido_delet
  before delete
  on pedido
  for each row
begin
  delete from itens_pedido WHERE itens_pedido.id_pedido = old.id_pedido;
end;



CREATE TRIGGER update_itens
  after update
  on itens_pedido
  for each row
begin
  update pedido
  set vl_total = vl_total -
                 (select valor * old.qtd
                  from produto
                  where id_produto = old.id_produto) +
                 (select valor * new.qtd
                  from produto
                  where id_produto = new.id_produto)
  where id_pedido = old.id_pedido;
end;

update itens_pedido
set qtd = 20
where id_itens_pedido = 5;

select *
from itens_pedido;

alter table pedido
  add constraint pedido_data_atual
    check ( data = cast(sysdate() as date) );

insert cliente
VALUES (1, 'paulo', '11391586433'),
       (2, 'andre', '12345678910'),
       (3, 'aryane', '10987654321');

insert produto
VALUES (1, 'agua', 1),
       (2, 'miojo', 0.75),
       (3, 'empanado', 1.1);

insert itens_pedido
values (1, 6, 1, 1),
       (2,3,1,2);

insert pedido
values (2, sysdate(), 2, 0);

alter TABLE itens_pedido
drop column id_itens_pedido;

create procedure Inserir_itens_pedido(in pIdproduto int, in pQtd int, in pIdpedido int)
begin
  insert itens_pedido values (pIdproduto, pQtd, pIdpedido);
end;

call Inserir_itens_pedido(3,4,2);



describe itens_pedido;
