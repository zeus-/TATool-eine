var TaHrIndexPage = React.createClass({
  getInitialState: function() {
    return {
      hrs: [],
      completeHrs: [],
      taOnline: this.props.ta.is_available
    }
  },

  updateHrs: function() {
    var self = this;
    $.get('/ta_help_requests', function(data) {
      self.setState({hrs: data.ta_help_requests});
    });
  },

  updateCompleteHrs: function() {
    var self = this;
    $.get('/complete_requests', function(data) {
      self.setState({completeHrs: data.ta_help_requests});
    });
  },
  
  goOffline: function() {
    var oldAvailability = this.props.ta.is_available
    var thisComponent = this
    $.ajax({
      url: '/ta_users/' + this.props.ta.id + "/",
      type: 'PATCH',
      data: {ta_user: {is_available: false}},
      success: function() {
      },
      error: function() {
        alert('Could not save!')
        thisComponent.setState({is_available: oldAvailability});
      }
    });
  },

  goOnline: function() {
    var oldAvailability = this.props.ta.is_available
    var thisComponent = this
    $.ajax({
      url: '/ta_users/' + this.props.ta.id + "/",
      type: 'PATCH',
      data: {ta_user: {is_available: true}},
      success: function() {
      },
      error: function() {
        alert('Could not save!')
        thisComponent.setState({is_available: oldAvailability});
      }
    });
  },
  componentDidMount: function() {
    var self = this;
    setInterval(function() { 
      self.updateHrs();
      self.updateCompleteHrs();
    }, 2000);
    self.updateHrs();
    self.updateCompleteHrs();
  },

  render: function() {
    var gravatarAddy = "http://www.gravatar.com/avatar/"  
    var taMD5Email = md5(this.props.ta.email)
    var taGravatarLink = gravatarAddy + taMD5Email
    var isAvailable = this.state.taOnline
    var loginButton;
    if (isAvailable ) {
      loginButton = <button className="offline" onClick={this.goOffline}> Go Offline </button>;
    } else {
      loginButton = <button className="online" onClick={this.goOnline} > Go Online </button>;
    }     
    return (
      <div>
        <div className="ta-panel">
        <img className="ta-panel-avatar" src= { taGravatarLink } > </img>
        <h1 className="ta-index-title">Hello {this.props.ta.first_name}</h1>
        <h2> Your pending help requests </h2> 
        { loginButton }
        </div>
        <TaHrList hrs={this.state.hrs} completeHrs={this.state.completeHrs} />
      </div>
    );
  }
});
