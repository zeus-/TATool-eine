var TaHrIndexPage = React.createClass({
  getInitialState: function() {
    return {
      hrs: this.props.hrs
    }
  },

  updateHrs: function() {
    var self = this;
    $.get('/ta_help_requests', function(data) {
      self.setState({hrs: data.ta_help_requests});
    });
  },

  componentDidMount: function() {
    var self = this;
    setInterval(function() { self.updateHrs() }, 2000);
    self.updateHrs();
  },

  render: function() {
    var gravatarAddy = "http://www.gravatar.com/avatar/"  
    var taMD5Email = md5(this.props.ta.email)
    var taGravatarLink = gravatarAddy + taMD5Email
             
    return (
      <div>
        <img className="ta-panel-avatar" src= { taGravatarLink } > </img>
        <h1 className="ta-panel-h1">Hello {this.props.ta.first_name}</h1>
        <TaHrList hrs={this.state.hrs} />
      </div>
    );
  }
});
