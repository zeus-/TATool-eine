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
        <h1 className="student-index-title">&nbsp;Available Teaching Assistants for {(new Date()).toString().split(' ').splice(1,3).join(' ') }</h1>
        <StudentHrList tas= {this.state.tas} forceUpdate={this.updateAnything}  />
      </div>
    );
  }
});
