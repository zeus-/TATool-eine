var StudentHrIndexPage = React.createClass({
  getInitialState: function() {
    return {
      tas: []
    }
  },
  updateAnything: function() {
    var self = this;
    $.get('/help_requests', function(taObject) {
      self.setState({ tas: taObject});
    });
  },

  componentDidMount: function() {
    var self = this;
    setInterval(function() { self.updateAnything() }, 2000);
    self.updateAnything();
  },

  alertUser: function() {
    alert("your turn!");
    /* console.log(window.currentUser); */
  },

  render: function() {
    return (
      <div>
        <h1>Available Tas with pending help requests</h1>
        <StudentHrList tas= {this.state.tas} forceUpdate={this.updateAnything}  />
      </div>
    );
  }
});
