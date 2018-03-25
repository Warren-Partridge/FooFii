package edu.bu.spark.foofii.login;

import android.app.ProgressDialog;
import android.content.Intent;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.v7.app.AppCompatActivity;
import android.text.SpannableString;
import android.text.style.RelativeSizeSpan;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

import com.google.android.gms.tasks.OnCompleteListener;
import com.google.android.gms.tasks.Task;
import com.google.firebase.auth.AuthResult;
import com.google.firebase.auth.FirebaseAuth;

import org.w3c.dom.Text;

import butterknife.BindView;
import butterknife.ButterKnife;
import edu.bu.spark.foofii.R;

/**
 * @author agrawroh
 * @version v1.0
 */
public class SignupActivity extends AppCompatActivity {
    private ProgressDialog progressDialog;

    private static final String TAG = "SignupActivity";

    @BindView(R.id.input_name)
    protected EditText nameText;

    @BindView(R.id.input_email)
    protected EditText emailText;

    @BindView(R.id.input_mobile)
    protected EditText mobileText;

    @BindView(R.id.input_password)
    protected EditText passwordText;

    @BindView(R.id.input_reEnterPassword)
    protected EditText reEnterPasswordText;

    @BindView(R.id.btn_signup)
    protected Button signupButton;

    @BindView(R.id.link_login)
    protected TextView loginLink;

    /* FireBase Authentication */
    private static FirebaseAuth mAuth;

    @Override
    public void onBackPressed() {
        showLogin();
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_signup);

        ButterKnife.bind(this); // not working

        /*
        nameText = new EditText(this);
        emailText = new EditText(this);
        mobileText = new EditText(this); // Don't think we want this... This can be optional
        passwordText = new EditText(this); // Don't want Password
        reEnterPasswordText = new EditText(this); // Don't want password
        */

        signupButton = (Button) findViewById(R.id.btn_signup);
        loginLink = (TextView) findViewById(R.id.link_login);

        /* Initialize Progress Dialog */
        progressDialog = new
                ProgressDialog(SignupActivity.this,
                R.style.AppTheme_Dark_Dialog);
        progressDialog.setIndeterminate(true);
        SpannableString spannableMessage = new SpannableString("Creating Account...");
        spannableMessage.setSpan(new RelativeSizeSpan(1.4f), 0, spannableMessage.length(), 0);
        progressDialog.setMessage(spannableMessage);

        /* FireBase Auth */
        mAuth = FirebaseAuth.getInstance();

        /* Do Sign Up */
        signupButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                signup();
            }
        });

        /* Go Back */
        loginLink.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                showLogin();
            }
        });
    }

    /**
     * Show test Text
     */
    private void dialog() {
        Toast.makeText(this,"Test,Test,Test!",Toast.LENGTH_LONG);
    }

    /**
     * Show Login
     */
    private void showLogin() {
        Toast.makeText(this,"Changing Activities...",Toast.LENGTH_LONG).show();
        Intent intent = new Intent(getApplicationContext(), LoginActivity.class);
        startActivity(intent);
        finish();
        overridePendingTransition(R.anim.push_left_in, R.anim.push_left_out);
    }

    /**
     * Do Sign Up
     */
    private void signup() {
        /* Validate Form */
        if (!validateForm()) {
            onSignupFailed();
            return;
        }

        Toast.makeText(this,"Creating Account...",Toast.LENGTH_SHORT).show();

        /* Disable Sign Up Button */
        signupButton.setEnabled(false);

        /* Show Progress Dialog */
        showProgress();

        /* Create Account */
        String name = nameText.getText().toString();
        String email = emailText.getText().toString();
        String password = passwordText.getText().toString();
        createAccount(name, email, password);
    }

    /**
     * Sign Up Successful
     */
    private void onSignupSuccess() {
        hideProgress();
        signupButton.setEnabled(true);
        setResult(RESULT_OK, null);
        finish();
    }

    /**
     * Sign Up Failed
     */
    private void onSignupFailed() {
        hideProgress();
        Toast.makeText(getBaseContext(), "Error While Creating Account!", Toast.LENGTH_LONG).show();
        signupButton.setEnabled(true);
    }

    /**
     * Show Progress
     */
    private void showProgress() {
        progressDialog.show();
    }

    /**
     * Hide Progress
     */
    private void hideProgress() {
        progressDialog.dismiss();
    }

    /**
     * Create Account
     *
     * @param email
     * @param password
     */
    private void createAccount(final String name, final String email, final String password) {
        mAuth.createUserWithEmailAndPassword(email, password)
                .addOnCompleteListener(this, new OnCompleteListener<AuthResult>() {
                    @Override
                    public void onComplete(@NonNull Task<AuthResult> task) {
                        if (task.isSuccessful()) {
                            LoginActivity.createUser(email, name);
                            onSignupSuccess();
                        } else {
                            onSignupFailed();
                        }
                    }
                });
    }

    /**
     * Validate
     *
     * @return isSuccess
     */
    private boolean validateForm() {

        Toast.makeText(this,"Validating Form...",Toast.LENGTH_SHORT).show();

        /* Set Default Validator Response */
        boolean valid = true;

        /* Get Flags */
        String name = nameText.getText().toString();
        String email = emailText.getText().toString();
        String mobile = mobileText.getText().toString();
        String password = passwordText.getText().toString();
        String reEnterPassword = reEnterPasswordText.getText().toString();

        /* Validate Name */
        if (name.isEmpty() || name.length() < 3) {
            nameText.setError("at least 3 characters");
            valid = false;
        } else {
            nameText.setError(null);
        }

        /* Validate Email Address */
        if (email.isEmpty() || !android.util.Patterns.EMAIL_ADDRESS.matcher(email).matches()) {
            emailText.setError("Enter a valid email address");
            valid = false;
        } else {
            emailText.setError(null);
        }

        /* Validate Mobile Number */
        if (mobile.isEmpty() || mobile.length() != 10) {
            mobileText.setError("Enter Valid Mobile Number");
            valid = false;
        } else {
            mobileText.setError(null);
        }

        /* Validate Password */
        if (password.isEmpty() || password.length() < 6 || password.length() > 15) {
            passwordText.setError("Enter a valid password between 4 - 15 characters");
            valid = false;
        } else {
            passwordText.setError(null);
        }

        /* Validate Re-Entered Password */
        if (reEnterPassword.isEmpty() || reEnterPassword.length() < 6 || reEnterPassword.length() > 15 || !(reEnterPassword.equals(password))) {
            reEnterPasswordText.setError("Password don't match");
            valid = false;
        } else {
            reEnterPasswordText.setError(null);
        }

        /* Return Validator Response */
        return valid;
    }
}