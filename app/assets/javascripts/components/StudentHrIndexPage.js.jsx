var StudentHrIndexPage = React.createClass({
  getInitialState: function() {
    return {
      tas: this.props.tas 
    }
  },

  updateAnything: function() {
    var self = this;
    $.get('/help_requests', function(messages) {
      console.log(messages)
      /*self.setState({tas: messages}); */
     // $("#wrap").html(messages);
    });
  },

  componentDidMount: function() {
    var self = this;
    setInterval(function() { self.updateAnything() }, 2000);
  },

  render: function() {
    return (
      <div>
        <h1>Available Tas with pending help requests</h1>
        { console.log(this.props.tas) }
      </div>
    );
  }
});
