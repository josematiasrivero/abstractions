<jsp:include page="/WEB-INF/jsp/header.jsp">
  <jsp:param name="title" value="Add property"/>
</jsp:include>

<body>
  <jsp:include page="/WEB-INF/jsp/navbar.jsp" />

  <div class="container">
    <div class="row">
      <div class="col-lg-12">
        <ol class="breadcrumb">
          <li><a href="/teams/">Teams</a></li>
          <li>${teamName}</li>
          <li><a href="/teams/${teamId}/applications/">Applications</a></li>
          <li>${applicationName}</li>
          <li><a href="/teams/${teamId}/applications/${applicationId}/properties/">Properties</a></li>
          <li class="active">Add property</li>
        </ol>
      </div>

      <div class="row">
        <div class="col-lg-9">
          <form class="form-horizontal" role="form" name="form" action="add" method="POST">

            <div class="form-group">
              <label for="inputName" class="col-lg-2 control-label">Property name</label>
              <div class="col-lg-10">
                <input type="text" class="form-control" id="inputName" name="name" placeholder="Property name...">
              </div>
            </div>

            <div class="form-group">
              <label for="inputValue" class="col-lg-2 control-label">Property value</label>
              <div class="col-lg-10">
                <input type="text" class="form-control" id="inputValue" name="value" placeholder="Property value...">
              </div>
            </div>
            
            <div class="form-group">
                <label for="inputProperyEnvironment" class="col-lg-2 control-label">Property Environment</label>

                <div class="col-lg-10">
                    <select class="form-control" id="inputProperyEnvironment" name="environment">
                        <option>DEV</option>
                        <option>QA</option>
                        <option>PROD</option>
                        <option>STG_ALPHA</option>
                        <option>STG_BETA</option>
                    </select>
                </div>
            </div>

            <div class="form-group">
              <div class="col-lg-offset-2 col-lg-10">
                <button type="submit" class="btn btn-primary">Save</button>
              </div>
            </div>
          </form>
        </div>
      </div>

    </div>
</body>
</html>
