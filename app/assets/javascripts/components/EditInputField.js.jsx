var EditInputField = React.createClass({
  getInitialState: function() {
    return {
      text: this.props.hrs.description,
      show: true
    }
  },

  updateNewHrValue: function() {
    var input = this.refs.newHr.getDOMNode();
    this.setState({text: input.value});
  },
   
  updateHr: function(e) {
   e.preventDefault();
   studentHrs = this.props.hrs
   node = this;
    $.ajax({
      url: '/students/' + studentHrs.student_id + '/help_requests/' + studentHrs.id,
      type: 'PATCH',
      data: {help_request: {description: this.state.text}},
      success: function() {
        //$(node.refs.newHr.getDOMNode()).hide();
        node.setState({ show: false }); 
      },
      error: function() {
       alert('Could not update!') 
      }
    })
  },

  render: function() {
            var self = this;
            var component;
            if (self.state.show) {  
            component= <form onSubmit= {this.updateHr}>  
                         <input value= {this.state.text} 
                                onChange={this.updateNewHrValue} 
                                ref= "newHr">
                         </input>
                        </form>
            } else { 
              component = "I need help with " + self.state.text
            }
        return (
            <span>
            { component }
            </span>
        );
    }
});
