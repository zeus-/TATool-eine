var EditDescription = React.createClass({
  getInitialState: function() {
    return {
      text: this.props.hrs.description,
      show: false
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
  openInput: function() {             
  /* var elem = (this.refs.x.getDOMNode())
    elem.outerHTML = "<input id='xx' refs='xxx'> </input>";
    var input = document.getElementById("xx")
    input.value = studentHrs.description;
    input.onSubmit 
    console.log(input) */          
   this.setState({ show: true }); 
  },

  render: function() {
            var self = this;
            var component;
            if (self.state.show) {  
              component= 
              <div>
                <div className="student-description"> 
                  <form className="edit-input" onSubmit= {this.updateHr}>  
                    <input value= {this.state.text} 
                      onChange={this.updateNewHrValue} 
                      ref= "newHr">
                    </input>
                    <br> </br>
                    <input type="submit" value="Submit Again" className="edit-submit-button"></input> 
                  </form>
                </div>
                <div className="edit-in-place-icon"> 
                  ...
                </div>
              </div>
            } else { 
              component = 
              <div>
                <div className="student-description"> 
                  I need help with { self.state.text} 
                </div>
                <h5> -Asked by: {self.props.hrs.student_full_name} </h5>
                <div className="edit" onClick= {self.openInput}> 
                  <i className="fa fa-pencil fa-lg"></i> 
                </div>
              </div>
            }
        return (
            <span>
            { component }
            </span>
        );
    }
});
