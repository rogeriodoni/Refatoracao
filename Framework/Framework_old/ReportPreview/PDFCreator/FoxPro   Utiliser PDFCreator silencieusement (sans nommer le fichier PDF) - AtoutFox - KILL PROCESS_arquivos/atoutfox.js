// Pour afficher un mail (anti-spam)
function MailTo($email)
{
  $email = $email.replace("*", "@");
  document.write("<a href=\"mailto:" + $email + "\">" + $email + "</a>");
}

// Formulaire en Ajax
var AjaxForm = new Class({

  Implements: Options,
  input: null,

  options: {
    //id du formulaire qui devient l'objet 
    form: null,
    // évenement se produisant avant le post du formulaire
    onSend: null,
    // évenement se produisant lorsque les champs ont été enregistrés sans erreur
    onSuccess: null
  },

  initialize: function ($options) {
    this.setOptions($options);
    this.options.form = $(this.options.form);
    var $submits = this.options.form.getElements("input[type=submit]");
    if ($submits.length > 0) {
      this.input = $submits[0];
      this.input.title = this.input.value;
    }
    try {
      this.options.form.get("send").removeEvents("complete");
    }
    catch ($err) { }
    this.options.form.get("send").addEvent("complete", this.onComplete.bind(this));
    this.options.form.removeEvents("submit");
    this.options.form.addEvent("submit", this.submit.bind(this));
  },

  submit: function ($event) {
    if ($event)
      $event.stop();
    if (this.input) {
      this.input.disabled = true;
      this.input.value = "Patientez ...";
    }
    if (this.options.onSend)
      this.options.onSend.attempt();
    this.options.form.send();
    return true;
  },

  onComplete: function ($response) {
    if (this.input) {
      this.input.value = this.input.title;
      this.input.disabled = false;
    }
    $response = JSON.decode($response);
    if ($response.ok) {
      if (this.options.onSuccess)
        this.options.onSuccess.attempt($response);
      else
        alert("Sauvegarde réussie");
    }
    else
      alert($response.message);
  }

});