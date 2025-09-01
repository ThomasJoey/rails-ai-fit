
# TODO

- Ajouter message reference sur message

- Ajouter le belongs_to et has_many qui vont bien

- Décommenter le bout de code qui associe l'event au message dans le messages controller

- Tweaker le prompt pour lui dire d'inclure aussi une clef "reply" au meme niveau que "events" qui est la réponse textuelle de l'assistant

- Coté messages controller, dans le message de l'assistant, en tant que message.content, enregistrer non pas tout le json mais uniquement le contenu de la clef "reply"
- Dans la show de la convo, afficher les events associes a un message



<%= turbo_stream.replace "signup-popup" do %>
  <div id="signup-popup" class="popup">
    <div class="popup-content">
      <h3>✅ Inscription réussie</h3>
      <p>Vous êtes bien inscrit à l’événement.</p>
      <button class="btn-close" data-action="click->events#closePopup">Fermer</button>
    </div>
  </div>
<% end %>
