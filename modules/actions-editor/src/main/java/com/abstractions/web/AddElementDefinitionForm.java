package com.abstractions.web;

/**
 *
 * @author Guido J. Celada
 */
public class AddElementDefinitionForm {
        private String name;
	private String displayName;
	private String icon;
	private String implementation;
	private boolean isScript;

    /**
     * @return the name
     */
    public String getName() {
        return name;
    }

    /**
     * @param name the name to set
     */
    public void setName(String name) {
        this.name = name;
    }

    /**
     * @return the displayName
     */
    public String getDisplayName() {
        return displayName;
    }

    /**
     * @param displayName the displayName to set
     */
    public void setDisplayName(String displayName) {
        this.displayName = displayName;
    }

    /**
     * @return the icon
     */
    public String getIcon() {
        return icon;
    }

    /**
     * @param icon the icon to set
     */
    public void setIcon(String icon) {
        this.icon = icon;
    }

    /**
     * @return the implementation
     */
    public String getImplementation() {
        return implementation;
    }

    /**
     * @param implementation the implementation to set
     */
    public void setImplementation(String implementation) {
        this.implementation = implementation;
    }

    /**
     * @return the isScript
     */
    public boolean getIsScript() {
        return isScript;
    }

    /**
     * @param isScript the isScript to set
     */
    public void setIsScript(boolean isScript) {
        this.isScript = isScript;
    }

}
