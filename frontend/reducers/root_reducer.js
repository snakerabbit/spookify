import { combineReducers} from 'redux';
import SessionReducer from './session_reducer';
import ErrorsReducer from './errors_reducer';
import UsersReducer from './users_reducer';

export default combineReducers({
  session: SessionReducer,
  errors: ErrorsReducer,
  users: UsersReducer
});
