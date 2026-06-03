# godot.addon.CustomArea2D
 esboço e feedback para o addon que pretendo desenvolver


-Como integrar?
  <br>Adicione um node novo na cena (Ctrl+a) e busque por "CustomArea2D".
 No node, selecione o grupo pela qual ele irá detectar colisão na variável Group.
 Utilize o signal 'trigger' para ativar, no momento da colisão, a função de outro node da mesma cena.

 Opcional: Você pode adicionar o Group seleciona no array 'Group Set' apertando o botão 'Add To GroupSet', permitindo ter detecções de multiplos grupos.

 -Como configurar os grupos que aparecem na listagem do Group. <br>
 Entre no script 'config.gd' e coloque os nomes dos grupos desejados como valores de String dentro do Array 'groups'


 -Em breve <br>
 Será possível passar informações na chamada da colisão.

-Diagrama de Uso:
![diagrama de uso](https://github.com/HeadlessBr/godot.addon.CustomArea2D/blob/main/diagram.webp)
